const { Pool } = require("pg");

const pool = new Pool({
    host: "dpg-chekenu7avj55m4juuvg-a.oregon-postgres.render.com",
    database: "adb_l197",
    user: "adb_l197_user",
    password: "9QOdRBBH8EkaQXwpmQ3ue4wkD6KQJH8x",
    port: 5432,
    ssl: true,
});

//Add Listener for the pool in case of any error happend
pool.on("error", (error) => {
    console.log(error.message);
});

//test database connection
pool.connect()
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

module.exports = pool;
