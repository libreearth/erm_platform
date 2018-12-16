// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
//import Muuri from "muuri"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
//import "./navbar"
import "./bulma"
import "./map"


window.onload = () => {
    eachSelected(".remove-array-item", (el) => el.onclick = removeItem);
    eachSelected(".add-array-item", (el) => el.onclick = addItem);
    eachSelected(".add-content-item", (el) => el.onclick = addContentItem);
    eachSelected(".remove-content-item", (el) => el.onclick = removeItem);
    eachSelected(".board", (el) => initBoard(el));
}

const eachSelected = (selector, fn) => {
    Array.prototype.forEach.call(document.querySelectorAll(selector), fn);
} 

const addItem = ({target: {dataset}}) => {
    let container = document.getElementById(dataset.container);
    let count = container.children.length;
    let blueprint = dataset.blueprint.replace(/index_holder/g, count);
    container.insertAdjacentHTML("beforeend", blueprint);
    let newItem = container.lastChild;
    newItem.lastChild.onclick = removeItem;
    newItem.firstChild.dataset.index = count;
    newItem.firstChild.id += "_" + count;
    newItem.firstChild.focus();
}

const removeItem = (event) => {
    let index = event.target.dataset.index;
    let li = event.target.parentNode;
    let ol = li.parentNode;
    ol.removeChild(li);
    Array.prototype.forEach.call(ol.children, (x, i) => 
        x.firstChild.dataset.index = i
    );
}

const addContentItem = ({target: {dataset}}) => { 
    let container = document.getElementById(dataset.container);
    let input= document.getElementById(dataset.input);
    let count = container.children.length;
    let blueprint = dataset.blueprint.replace(/key_placeholder/g, input.value);
    container.insertAdjacentHTML("beforeend", blueprint);
    let newItem = container.lastChild;
    newItem.lastChild.onclick = removeItem;
    newItem.firstChild.dataset.index = count;
    newItem.firstChild.id += "_" + count;
    newItem.firstChild.focus();
}

const initBoard = (el) => {
    console.log("initboard called")
    console.log(el)

    var itemContainers = [].slice.call(document.querySelectorAll('.board-column-content'));
    console.log(itemContainers)
    var columnGrids = [];
    var boardGrid;

// Define the column grids so we can drag those
// items around.
itemContainers.forEach(function (container) {
    console.log(container)

  // Instantiate column grid.
  var grid = new Muuri(container, {
    items: '.board-item',
    layoutDuration: 400,
    layoutEasing: 'ease',
    dragEnabled: true,
    dragSort: function () {
      return columnGrids;
    },
    dragSortInterval: 0,
    dragContainer: document.body,
    dragReleaseDuration: 400,
    dragReleaseEasing: 'ease'
  })
  .on('dragStart', function (item) {
    // Let's set fixed widht/height to the dragged item
    // so that it does not stretch unwillingly when
    // it's appended to the document body for the
    // duration of the drag.
    item.getElement().style.width = item.getWidth() + 'px';
    item.getElement().style.height = item.getHeight() + 'px';
  })
  .on('dragReleaseEnd', function (item) {
    // Let's remove the fixed width/height from the
    // dragged item now that it is back in a grid
    // column and can freely adjust to it's
    // surroundings.
    console.log(item.getElement());
    item.getElement().style.width = '';
    item.getElement().style.height = '';
    // Just in case, let's refresh the dimensions of all items
    // in case dragging the item caused some other items to
    // be different size.
    columnGrids.forEach(function (grid) {
      grid.refreshItems();
    });
  })
  .on('layoutStart', function () {
    // Let's keep the board grid up to date with the
    // dimensions changes of column grids.
    boardGrid.refreshItems().layout();
  });

  // Add the column grid reference to the column grids
  // array, so we can access it later on.
  columnGrids.push(grid);

});

// Instantiate the board grid so we can drag those
// columns around.
boardGrid = new Muuri('.board', {
  layoutDuration: 400,
  layoutEasing: 'ease',
  dragEnabled: true,
  dragSortInterval: 0,
  dragStartPredicate: {
    handle: '.board-column-header'
  },
  dragReleaseDuration: 400,
  dragReleaseEasing: 'ease'
});
}