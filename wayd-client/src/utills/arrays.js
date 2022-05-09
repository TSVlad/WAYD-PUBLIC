function range(start, end) {
    return Array.apply(0, Array(end))
        .map((element, index) => index + start);
}

export {range}