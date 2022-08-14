const Bootstrap = () => {
    return (
        <>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        </>
    );
}

function AddScript() {
    return (
        <>
            <script type="text/javascript" src="%PUBLIC_URL%/../src/js/script-base.js"></script>
            <script type="text/javascript" src="%PUBLIC_URL%/../src/js/script-sales.js"></script>
        </>
    );
}


export { Bootstrap, AddScript };