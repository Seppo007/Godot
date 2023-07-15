export class GameCharacter {
    constructor(x, y, speed = 1, width = 50, height = 50, color = 'rgb(255, 0, 0)') {
        this.x = x;
        this.y = y;
        this.speed = speed;
        this.width = width;
        this.height = height;
        this.color = color;
        this.maxSpeed = 1;
    }

    move = (xAmount, yAmount) => {
        this.x += xAmount;
        this.y += yAmount;
    }
}