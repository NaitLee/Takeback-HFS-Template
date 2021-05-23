[+common-html]
<style>
a:hover {
    animation: pulse 1.75s infinite cubic-bezier(0.66, 0, 0, 1);
}
@keyframes pulse {
    to {
        box-shadow: 0 0 0 30px rgba(255, 255, 255, 0);
    }
}
a:not(.invert) {
    box-shadow: 0 0 0 0 rgba(255, 255, 255, 0.7);
}
</style>
