<!-- Contact Us Button -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#contactUsModal">
    Contact Us
</button>

<!-- Contact Us Modal -->
<div class="modal fade" id="contactUsModal" tabindex="-1" aria-labelledby="contactUsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="contactUsModalLabel">Contact Us</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="contactForm">
                    <div class="mb-3">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter your name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email address</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter your email" required>
                    </div>
                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject</label>
                        <input type="text" class="form-control" id="subject" placeholder="Enter subject" required>
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Message</label>
                        <textarea class="form-control" id="message" rows="3" placeholder="Enter your message" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (Make sure Bootstrap is included in your project) -->
<script>
document.getElementById('contactForm').addEventListener('submit', function(event) {
    event.preventDefault();
    alert('Your message has been sent successfully!');
    var modal = new bootstrap.Modal(document.getElementById('contactUsModal'));
    modal.hide();
    this.reset();
});
</script>
