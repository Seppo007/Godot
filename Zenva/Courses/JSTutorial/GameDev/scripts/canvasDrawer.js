import Canvas from "./canvas.js";

const {canvasCtx, SCREEN_WIDTH, SCREEN_HEIGHT} = Canvas;

const sprites = {
    player: new Image(42, 23),
    enemy: new Image(50, 50),
    background: new Image(800, 600),
    blob: new Image(50, 50)
}

export const loadSprites = () => {
    sprites.player.src = 'assets/froggy.png';
    sprites.enemy.src = 'assets/car_scraped.png';
    sprites.background.src = 'assets/way.png';
    sprites.blob.src = 'assets/frog_blob.png';
}

const drawBackground = () => canvasCtx.drawImage(sprites.background, 0, 0, sprites.background.width, sprites.background.height);

const drawPlayerAndFinish = (player, finish) => {
    canvasCtx.fillStyle = finish.color;
    canvasCtx.fillRect(finish.x, finish.y, finish.width, finish.height);

    canvasCtx.drawImage(sprites.player, player.x, player.y, 42, 23);
}

const drawEnemies = (enemies) => {
    for (const rect of enemies) {
        canvasCtx.save();
        if (rect.speed > 0) {
            var TO_RADIANS = Math.PI / 180;
            canvasCtx.translate(rect.x, rect.y);
            canvasCtx.rotate(180 * TO_RADIANS);
            canvasCtx.drawImage(sprites.enemy, -sprites.enemy.width, -sprites.enemy.height, sprites.enemy.width, sprites.enemy.height);
            canvasCtx.translate(-rect.x, -rect.y);
        } else {
            canvasCtx.drawImage(sprites.enemy, rect.x, rect.y, sprites.enemy.width, sprites.enemy.height);
        }
        canvasCtx.restore();
    }
}

const drawEndingScene = (player, enemies) => {
    canvasCtx.clearRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    drawBackground();
    canvasCtx.drawImage(sprites.blob, player.x - player.width / 2, player.y - player.height / 2, 60, 60)
    drawEnemies(enemies);
}

export default {drawBackground, drawPlayerAndFinish, drawEnemies, drawEndingScene}