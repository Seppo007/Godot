const MY_CANVAS_ID = 'myCanvas';

const canvas = document.getElementById(MY_CANVAS_ID);
const canvasCtx = canvas.getContext('2d');

export const SCREEN_WIDTH = canvas.width;
export const SCREEN_HEIGHT = canvas.height;

export default {canvas, canvasCtx, SCREEN_WIDTH, SCREEN_HEIGHT}