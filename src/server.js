const express = require("express");
const db = require("./database");
const cors = require("cors");

const app = express();

//Middlewares
app.use(
    cors({
        origin: "*",
    })
);

//test database connection
db.connect()
    .then((client) => {
        return client
            .query("SELECT NOW()")
            .then((res) => {
                client.release();
                console.log(res.rows);
            })
            .catch((err) => {
                client.release();
                console.log(err.stack);
            });
    })
    .catch((err) => {
        console.log(err);
    });

//Routes
app.get("/", (req, res) => {
    res.status(200).json({ status: "success", message: "Hello world! " });
});

//GET all the customers data based on a minimum order count
app.get("/customers", async (req, res) => {
    const minOrders = req.query.min_order || 0;
    try {
        const conn = await db.connect();
        const query = {
            text: `SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS order_count
            FROM customer AS c 
            JOIN "order" AS o 
            ON c.customer_id = o.customer_id
            GROUP BY c.customer_id, c.first_name, c.last_name
            having count (o.order_id) > $1`,
            values: [minOrders],
        };
        const result = await conn.query(query);
        res.json({
            status: "success",
            results: result.rows.length,
            message: "customers retrived ",
            data: result.rows,
        });
    } catch (err) {
        res.status(500).json({
            status: "failed",
            msg: `Error retrieving min orders: ${err.message}`,
        });
    }
});

app.get("/customers/recent-orders", async (req, res) => {
    const days = req.query.days || 30;
    try {
        const conn = await db.connect();
        const query = {
            text: `SELECT C.customer_id, C.first_name, C.last_name
            FROM customer as C
            JOIN "order" as O 
            ON C.customer_id = O.customer_id
            WHERE O.placed_on >= CURRENT_DATE - INTERVAL '${days} days'`,
            // values: [days],
        };
        const result = await conn.query(query);
        res.json({
            status: "success",
            results: result.rows.length,
            message: "customers retrived ",
            data: result.rows,
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: "failed",
            msg: `Error retrieving recent customers: ${err.message}`,
        });
    }
});

//NOT FOUND ROUTES
app.use((_req, res) => {
    res.status(404).json({
        message: "THAT IS WRONG ROUTE!!",
    });
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`listening on port ${PORT}`);
});
