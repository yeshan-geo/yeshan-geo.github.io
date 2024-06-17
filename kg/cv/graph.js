var knowledge_graph_json = {};

// https://javascript.info/fetch
let response = await fetch('./data.json');

if (response.ok) { // if HTTP-status is 200-299
  knowledge_graph_json = await response.json();
} else {
  alert("HTTP-Error: " + response.status);
}

var nodes = []
var edges = []

for (const index in knowledge_graph_json['entities']) {
    nodes.push({
        data: {id: knowledge_graph_json['entities'][index]['title']}
    });
}

for (const index in knowledge_graph_json['relations']) {
    edges.push({
        data: {
            id: index,
            source: knowledge_graph_json['relations'][index]['source'],
            target: knowledge_graph_json['relations'][index]['target'],
            label: knowledge_graph_json['relations'][index]['type'],
        }
    });
}

var cy = cytoscape({
    container: document.getElementById('cy'),
    elements: {
        nodes: nodes,
        edges: edges
    },
    style: [
        {
            selector: 'node',
            style: {
                "text-valign" : "center",
                "text-halign" : "center",
                "label": 'data(id)',
                "width" : 100,
                "height" : 100
            }
        },
        {
            selector: 'edge',
            style: {
                'width': 5,
                'line-color': 'light grey',
                'target-arrow-color': 'grey',
                'target-arrow-shape': 'triangle',
                'curve-style': 'bezier',
                'label': 'data(label)'
            }
        }
    ]
});

cy.layout({
    name: 'cose'
}).run();
