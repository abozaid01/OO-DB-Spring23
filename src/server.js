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

//GET top [n] best-selling products by revenue
app.get("/products", async (req, res) => {
    try {
        const top = req.query.top;
        console.log(top);
        const conn = await db.connect();
        const query = `SELECT P.product_id, P.description, SUM(OI.quantity * P.price) AS revenue
        FROM product P
        JOIN order_item OI ON P.product_id = OI.product_id
        GROUP BY P.product_id, P.description
        ORDER BY revenue DESC
        LIMIT $1;
    `;

        const result = await conn.query(query, [top]);
        res.json({
            status: "success",
            results: result.rows.length,
            message: "products retrived ",
            data: result.rows,
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: "failed",
            msg: `Error retrieving recent products: ${err.message}`,
        });
    }
});

//GET top categories based on total sales
app.get("/category/total-sales", async (req, res) => {
    try {
        const conn = await db.connect();
        const query = `SELECT c.name, COUNT(*) as total_sales
                        FROM order_item as oi, product as p, category as c
                        WHERE oi.product_id = p.product_id and c.category_id = p.category_id
                        GROUP BY p.product_id, c.name
                        ORDER BY total_sales desc`;

        const result = await conn.query(query);
        conn.release();

        res.json({
            status: "success",
            results: result.rows.length,
            message: "categories retrived ",
            data: result.rows,
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: "failed",
            msg: `Error retrieving totals-sales categories: ${err.message}`,
        });
    }
});

//GET top categories based on quantity
app.get("/category/total-sales-quantity", async (req, res) => {
    try {
        const conn = await db.connect();
        const query = `SELECT c.name, COUNT(*) as total_sales
                        FROM order_item as oi, product as p, category as c
                        WHERE oi.product_id = p.product_id and c.category_id = p.category_id
                        GROUP BY p.category_id, c.name
                        ORDER BY total_sales DESC`;

        const result = await conn.query(query);
        conn.release();

        res.json({
            status: "success",
            results: result.rows.length,
            message: "categories retrived ",
            data: result.rows,
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: "failed",
            msg: `Error retrieving totals-sales categories based on quantity: ${err.message}`,
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
