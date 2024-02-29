document.addEventListener("DOMContentLoaded", function() {
    const personForm = document.getElementById("person-form");
    const detailForm = document.getElementById("detail-form");
    const peopleList = document.getElementById("people-list");
    const detailList = document.getElementById("detail-list");

    // Function to fetch and display people
    function fetchPeople() {
        fetch("/people.json")
            .then(response => response.json())
            .then(data => {
                peopleList.innerHTML = "";
                data.forEach(person => {
                    const li = document.createElement("li");
                    li.textContent = `${person.name} - ${person.email}`;
                    peopleList.appendChild(li);
                });
            })
            .catch(error => console.error("Error fetching people:", error));
    }

    // Function to fetch and display details
    function fetchDetails() {
        fetch("/details.json")
            .then(response => response.json())
            .then(data => {
                detailList.innerHTML = "";
                data.forEach(detail => {
                    const li = document.createElement("li");
                    li.textContent = `${detail.detail_type}: ${detail.detail_value}`;
                    detailList.appendChild(li);
                });
            })
            .catch(error => console.error("Error fetching details:", error));
    }

    // Event listener for submitting person form
    personForm.addEventListener("submit", function(event) {
        event.preventDefault();
        const formData = new FormData(personForm);
        fetch("/people.json", {
            method: "POST",
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    fetchPeople();
                    personForm.reset();
                } else {
                    console.error("Failed to add person");
                }
            })
            .catch(error => console.error("Error adding person:", error));
    });

    // Event listener for submitting detail form
    detailForm.addEventListener("submit", function(event) {
        event.preventDefault();
        const formData = new FormData(detailForm);
        fetch("/details.json", {
            method: "POST",
            body: formData
        })
            .then(response => {
                if (response.ok) {
                    fetchDetails();
                    detailForm.reset();
                } else {
                    console.error("Failed to add detail");
                }
            })
            .catch(error => console.error("Error adding detail:", error));
    });

    // Fetch and display people and details on page load
    fetchPeople();
    fetchDetails();
});
