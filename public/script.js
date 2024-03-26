const option = document.getElementById('option');
const main  = document.getElementById('main');

option.addEventListener('change', async () => {
    if(option.value == 0) {
        return;
    }
    if(option.value == 1) {
        main.innerHTML = '<input type="text" id="query"> <input type="button" id="btn" value="submit">';
        const query = document.getElementById('query');
        const btn = document.getElementById('btn');
        btn.addEventListener('click', async () => {
            const {data} = await axios.post("http://localhost:5000/run",{query:query.value});
            populateTable(data)
        })
        return
    }
    const {data} = await axios.get(`http://localhost:5000/${option.value}`);
    populateTable(data);
    return;
})

function populateTable(data) {
    main.innerHTML = `<table id="data-table"> </table>`
    const table = document.getElementById("data-table");
    const headers = table.createTHead();
    const headerRow = headers.insertRow(0);
    for (const key in data[0]) {
        const headerCell = document.createElement("th");
        headerCell.innerHTML = key;
        headerRow.appendChild(headerCell);
    }
    data.forEach((item) => {
        const row = table.insertRow();
        for (const key in item) {
            if (item.hasOwnProperty(key)) {
                const cell = row.insertCell();
                cell.innerHTML = item[key];
            }
        }
    });
}