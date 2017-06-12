# Tutorial: Building a Language Server for your DSL using Xtext

In this tutorial you will learn how to create a language server for any Xtext DSL. For this example we use a simple language, that allows to do arithmetics with numbers and define and reuse functions. Here is the example script that we will use throughout the tutorial:

```
/** Calculates the area of a square. */
let square(a): pow(a, 2)

/** Calculates the area of a cirecle based on the radius argument. */
let circle(r): PI * pow(r, 2)

/** Returns with the volume of a cube. */
let cube(a): pow(a, 3) 

/** Calculates the volume of a sphere. */
let sphere(r): (4 / 3)  * PI * pow(r, 3)

let a: 10
let r: a / 2

let aSquare: square(a)
let aCircle: circle(r)

/** Evaluate the value of the area difference by hitting Shift + Enter. */
aSquare - aCircle

cube(a) - sphere(r)
```

You can find a working online demo of this here : http://monaco-demo.typefox.io/
