// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TodoEngine {
    address public owner;
    struct Todo {
        string title;
        string description;
        bool completed;
        // можно добавить метку времени (дедлайн)
    }

    Todo[] todos;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner!");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addTodo(string calldata _title, string calldata _description) external onlyOwner {
        todos.push(Todo({
            title: _title,
            description: _description,
            completed: false
        }));
    }

    function changeTodoTitle(string calldata _newTitle, uint _index) external onlyOwner {
        todos[_index].title = _newTitle;
        // Todo storage myTodo = todos[_index];
        // myTodo.title = _newTitle;
    }

    function getTodo(uint _index) external view onlyOwner returns(string memory, string memory, bool) {
        Todo storage myTodo = todos[_index];

        return (
            myTodo.title,
            myTodo.description,
            myTodo.completed
        );
    }

    function changeTodoStatus(uint index) external onlyOwner {
        todos[index].completed = !todos[index].completed;
    }

}