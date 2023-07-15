import Canvas from './canvas.js';
import {GameCharacter} from "./model/gameCharacter.js";
import drawToCanvas, {loadSprites} from "./canvasDrawer.js";

const GameState = Object.freeze({
    RUNNING: Symbol("running"),
    FINISHED: Symbol("finished"),
    GAMEOVER: Symbol("gameover")
});

const GAMEOVER_TEXT = 'gameoverText';
const FINISHED_TEXT = 'finishedText';
const gameoverText = document.getElementById(GAMEOVER_TEXT);
const finishedText = document.getElementById(FINISHED_TEXT);

const {canvas, canvasCtx, SCREEN_WIDTH, SCREEN_HEIGHT} = Canvas;
const {drawBackground, drawPlayerAndFinish, drawEnemies, drawEndingScene} = drawToCanvas;

const randomize = (value) => {
    return Math.round(Math.random() * 5 * value + (value < 0 ? -1 : 1));
}

const player = new GameCharacter(15, SCREEN_HEIGHT / 2, 0, 42, 23, 'rgb(0, 255, 0)')
const finish = new GameCharacter(SCREEN_WIDTH - 25, SCREEN_HEIGHT / 2 - 25, 0, 50, 100, 'rgb(0,0,0)');
const enemies = [
    new GameCharacter(SCREEN_WIDTH / 10, SCREEN_HEIGHT / 2, randomize(1)),
    new GameCharacter(SCREEN_WIDTH / 10 + 150, SCREEN_HEIGHT / 2, randomize(-2)),
    new GameCharacter(SCREEN_WIDTH / 10 + 300, SCREEN_HEIGHT / 2, randomize(3)),
    new GameCharacter(SCREEN_WIDTH / 10 + 450, SCREEN_HEIGHT / 2, randomize(-3)),
    new GameCharacter(SCREEN_WIDTH / 10 + 600, SCREEN_HEIGHT / 2, randomize(4)),
]

const onKeyDown = (event) => {
    const eventKey = event.key;
    if (eventKey === 'ArrowLeft' || eventKey === 'ArrowRight') {
        event.preventDefault();
        if (gameState === GameState.GAMEOVER || gameState === GameState.FINISHED) return;
        player.speed = player.maxSpeed * (eventKey === 'ArrowLeft' ? -1 : 1);
    }
    console.log("player input was", event.key);
}

const onKeyUp = (event) => {
    if (event.key === 'ArrowLeft' || event.key === 'ArrowRight') {
        player.speed = 0;
    }
}

const checkForCollision = () => {
    for (const enemy of enemies) {
        if (
            (Math.abs(player.x - enemy.x) < player.width && Math.abs(player.y - enemy.y) < player.height) ||
            (Math.abs(player.x + player.width - (enemy.x + enemy.width)) < player.width && Math.abs(player.y + player.height - (enemy.y + enemy.height)) < player.height)
        ) {
            gameState = GameState.GAMEOVER;
        } else if (player.x + player.width > finish.x) {
            gameState = GameState.FINISHED;
        }
    }
}

document.onkeydown = onKeyDown;
document.onkeyup = onKeyUp;

const draw = () => {
    canvasCtx.clearRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    drawBackground();
    drawEnemies(enemies);
    drawPlayerAndFinish(player, finish);
}

const update = () => {
    for (const enemy of enemies) {
        checkForCollision();
        movePlayerWithinCanvasConstraints();
        moveEnemyWithinCanvasConstraints(enemy);
    }
}

const moveEnemyWithinCanvasConstraints = (enemy) => {
    enemy.move(0, enemy.speed);
    if (enemy.y > SCREEN_HEIGHT) {
        enemy.y = 0 - enemy.height * 2;
    } else if (enemy.y + enemy.height * 2 < 0) {
        enemy.y = SCREEN_HEIGHT;
    }
}

const movePlayerWithinCanvasConstraints = () => {
    player.move(player.speed, 0);
    if (player.x < 0) {
        player.x = 0;
    } else if (player.x > SCREEN_WIDTH - player.width) {
        player.x = SCREEN_WIDTH - player.width;
    }
}

loadSprites();
let gameState = GameState.RUNNING;

const main = () => {
    update();
    draw();

    if (gameState === GameState.GAMEOVER) {
        drawEndingScene(player, enemies)
        gameoverText.setAttribute('class', 'end');
        canvas.setAttribute('class', 'end');
        return;
    } else if (gameState === GameState.FINISHED) {
        canvas.setAttribute('class', 'end');
        finishedText.setAttribute('class', 'end');
        return;
    }
    window.requestAnimationFrame(main);
}

main();