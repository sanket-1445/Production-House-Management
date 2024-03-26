import mysql from 'mysql2/promise'
import dotenv from 'dotenv'
dotenv.config()
import express from 'express';
import cors from 'cors';
const app = express();

app.use(cors())
app.use(express.static('./public'));

// data parse middleware
app.use(express.json());

const pool = mysql.createPool({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE
})

const queryResult = async (query) => {
    const [result] = await pool.query(query);
    return result
}

app.get('/production', async (req,res) => {
    const result = await queryResult(`SELECT p.production_id, p.production_firm, d.department_id, d.department_name
    FROM productions as p
    JOIN has_departments hd ON p.production_id = hd.production_id
    JOIN departments d ON hd.department_id = d.department_id`);
    res.json(result)
})

app.get('/series', async (req,res) => {
    res.json(await queryResult(`SELECT s.SeriesID, s.SeriesName, s.Reviews, s.Budget, g.genre_type
    FROM Series s
    LEFT JOIN Genre g ON s.SeriesID = g.SeriesID;`))
})

app.get('/department', async (req,res) => {
    res.json(await queryResult(`SELECT e.emp_id, e.first_name, e.last_name, e.middle_name, e.DOB, d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id;`))
})

app.get('/cast', async (req,res) => {
    res.json(await queryResult(`SELECT c.cast_id, e.first_name, e.last_name, c.num_of_episodes, c.name_in_series, s.SeriesName
    FROM Cast c
    JOIN employees e ON c.emp_id = e.emp_id
    JOIN works_for w ON e.emp_id = w.emp_id
    JOIN Series s ON w.Seriesid = s.SeriesID;`))
})

app.get('/grievances', async (req,res) => {
    res.json(await queryResult(`SELECT g.emp_id, e.first_name, e.last_name, g.grievance_text
    FROM Grievances g
    JOIN employees e ON g.emp_id = e.emp_id;`))
})

app.get('/crewmembers', async (req,res) => {
    res.json(await queryResult(`SELECT cm.crew_member_id, e.first_name, e.last_name, cm.contract_duration, cm.designation
    FROM CrewMembers cm
    JOIN employees e ON cm.emp_id = e.emp_id;`))
})

app.get('/writer', async (req,res) => {
    res.json(await queryResult(`SELECT sw.script_id, e.first_name, e.last_name, sw.script_name
    FROM Script_writer sw
    JOIN employees e ON sw.emp_id = e.emp_id;`))
})

app.get('/release', async (req,res) => {
    res.json(await queryResult(`SELECT rg.R_ID, rg.Platform, rg.ReleaseDate, s.SeriesName
    FROM ReleaseGroup rg
    JOIN Series s ON rg.SeriesID = s.SeriesID;`))
})

app.get('/genre', async (req,res) => {
    res.json(await queryResult(`SELECT SeriesID, GROUP_CONCAT(genre_type) AS Genres
    FROM Genre
    GROUP BY SeriesID;`))
})

app.get('/employees', async (req,res) => {
    res.json(await queryResult(`SELECT emp_id, first_name, last_name, DOB, YEAR(CURDATE()) - YEAR(DOB) AS age
    FROM employees;`))
})

app.post('/run',async (req,res) => {
    const {query} = req.body;
    res.json(await queryResult(query));
})

app.listen(process.env.PORT, () => {
    console.log("Listening to the port 5000");
})