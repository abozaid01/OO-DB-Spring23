const express = require("express");
const db = require("./database");
const cors = require("cors");

const app = express();

//Middlewares
app.use(cors());

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

app.get("/customers:id", async (req, res) => {
    try {
        const conn = await db.connect();
        const sql = `SELECT * FROM "customer"`;
        const result = await conn.query(sql);
        conn.release();

        res.json({
            status: "success",
            results: result.rows.length,
            message: "customers retrived ",
            data: result.rows,
        });
    } catch (error) {
        res.json({
            status: "failed",
            msg: `unable to get customers: ${error.message}`,
        });
    }
});

app.get("/customers/recent-orders:days?", async (req, res) => {
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
