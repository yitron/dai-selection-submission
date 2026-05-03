/**
 * GEOCITIES REVIVAL - AI DAI HOMEPAGE
 * JavaScript Functionality
 *
 * Features:
 * - Hit counter with localStorage persistence
 * - Smooth scroll enhancements
 * - Interactive effects
 */

// ============================================
// HIT COUNTER CLASS
// ============================================

class HitCounter {
    constructor(storageKey = 'aidai_hit_count') {
        this.storageKey = storageKey;
        this.counterElement = document.getElementById('hitCounter');

        if (!this.counterElement) {
            console.error('Hit counter element not found');
            return;
        }

        // Initialize counter
        this.init();
    }

    /**
     * Initialize the hit counter
     * Loads from localStorage, increments, and displays
     */
    init() {
        const currentCount = this.load();
        const newCount = this.increment(currentCount);
        this.store(newCount);
        this.display(newCount);
    }

    /**
     * Load hit count from localStorage
     * @returns {number} Current hit count (default 0)
     */
    load() {
        try {
            const stored = localStorage.getItem(this.storageKey);
            return stored ? parseInt(stored, 10) : 0;
        } catch (error) {
            console.warn('localStorage not available:', error);
            return 0;
        }
    }

    /**
     * Store hit count to localStorage
     * @param {number} count - Hit count to store
     */
    store(count) {
        try {
            localStorage.setItem(this.storageKey, count.toString());
        } catch (error) {
            console.warn('Could not save to localStorage:', error);
        }
    }

    /**
     * Increment hit count
     * @param {number} currentCount - Current count
     * @returns {number} Incremented count
     */
    increment(currentCount) {
        return currentCount + 1;
    }

    /**
     * Display hit count with leading zeros (classic Geocities style)
     * @param {number} count - Hit count to display
     */
    display(count) {
        // Format with leading zeros (6 digits)
        const formatted = count.toString().padStart(6, '0');
        this.counterElement.textContent = formatted;
    }

    /**
     * Get current hit count
     * @returns {number} Current count
     */
    get() {
        return this.load();
    }

    /**
     * Reset hit count (for testing purposes)
     */
    reset() {
        this.store(0);
        this.display(0);
        console.log('Hit counter reset to 0');
    }
}

// ============================================
// SMOOTH SCROLL ENHANCEMENTS
// ============================================

/**
 * Add smooth scroll behavior to navigation links
 * (Backup for browsers that don't support CSS scroll-behavior)
 */
function initSmoothScroll() {
    const navLinks = document.querySelectorAll('a[href^="#"]');

    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const targetId = this.getAttribute('href');

            // Skip if it's just '#'
            if (targetId === '#') {
                e.preventDefault();
                return;
            }

            const targetElement = document.querySelector(targetId);

            if (targetElement) {
                e.preventDefault();

                // Smooth scroll to target
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });

                // Update URL hash without jumping
                history.pushState(null, null, targetId);

                // Focus target for accessibility
                targetElement.focus({ preventScroll: true });
            }
        });
    });
}

// ============================================
// EASTER EGGS & FUN EFFECTS
// ============================================

/**
 * Add random sparkle effect on page interactions
 */
function addSparkleEffect() {
    const sparkleEmojis = ['✨', '⚡', '🌟', '💫', '⭐'];

    document.body.addEventListener('click', function(e) {
        // Random chance to spawn sparkle
        if (Math.random() > 0.7) {
            createSparkle(e.clientX, e.clientY);
        }
    });

    function createSparkle(x, y) {
        const sparkle = document.createElement('div');
        sparkle.textContent = sparkleEmojis[Math.floor(Math.random() * sparkleEmojis.length)];
        sparkle.style.position = 'fixed';
        sparkle.style.left = x + 'px';
        sparkle.style.top = y + 'px';
        sparkle.style.pointerEvents = 'none';
        sparkle.style.fontSize = '24px';
        sparkle.style.zIndex = '9999';
        sparkle.style.transition = 'all 1s ease-out';

        document.body.appendChild(sparkle);

        // Animate sparkle
        setTimeout(() => {
            sparkle.style.transform = 'translateY(-50px)';
            sparkle.style.opacity = '0';
        }, 10);

        // Remove after animation
        setTimeout(() => {
            sparkle.remove();
        }, 1000);
    }
}

/**
 * Konami Code Easter Egg
 * (Up, Up, Down, Down, Left, Right, Left, Right, B, A)
 */
function initKonamiCode() {
    const konamiCode = [
        'ArrowUp', 'ArrowUp',
        'ArrowDown', 'ArrowDown',
        'ArrowLeft', 'ArrowRight',
        'ArrowLeft', 'ArrowRight',
        'KeyB', 'KeyA'
    ];
    let konamiIndex = 0;

    document.addEventListener('keydown', (e) => {
        // Check if key matches the sequence
        if (e.code === konamiCode[konamiIndex]) {
            konamiIndex++;

            // If complete sequence
            if (konamiIndex === konamiCode.length) {
                activateSecretMode();
                konamiIndex = 0; // Reset
            }
        } else {
            konamiIndex = 0; // Reset on wrong key
        }
    });

    function activateSecretMode() {
        alert('🎮 KONAMI CODE ACTIVATED! 🎮\n\nYou found the secret! Welcome, fellow 90s kid!');

        // Add extra rainbow effect to entire page
        document.body.style.animation = 'rainbow 2s linear infinite';

        // Play a fun sound (if audio is supported)
        try {
            const audio = new Audio('data:audio/wav;base64,UklGRnoGAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQoGAACBhYqFbF1fdJivrJBhNjVgodDbq2EcBj+a2/LDciUFLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmwhBSuBzvLZiTYIGmi78OScTgwOUKrk7bRiHgU7k9bz0H8pBSl+zPLaizsKGGS56+mjUBELTKXh8bllHAU7ldrzzYMtBSl6yPDckz0LEGCz6+mmVBULTqfi8bllHAU+ltv0yoEqBCh5x/DekhAKE2G16+mrWBUMUKnh8L1sJAU4kdXy0IItBSh8yvDfljsKFGK37OypWxoNVrDo8bliHQU7ldfzzIEtBSl7yPDblDsKEle06+mpVxMNTqPh8btkHgU3kdXy0IEqBCl7yPDfljsKElu17+mrWxwNVbDo8btkIAU6ldnzzYQwBil7x/DdlDoKEl227umnWRoMVK/n77pjHgU4lNTx0IIwBil9yPDgmT0LEl237O+oVxkNUqzi8bxlHQU7ldnzzYIuBip8yPDfljwKE2K27OypWhwNVbDp8b1nIAU7ldj0zIMuBil7x/DdkzoKEluw7OymWhkNUazi8L5oIAU9ltnzzYMxBih9yPHfmD4LElqw7O+oWhwNVa/p8b5pIQU+ltj0y4MtBil8x/DdlDoKEluw7O+oWhwOVKjp8b5pIQU9ltnzzYMxBih9yPHfmD4LElqw7O+oWhwNVa/p8b5pIQU+ltj0y4MtBil8x/DdlDoKEluw7O+oWhwOVKjp8b5pIQU9ltnzzYMxBih9yPHfmD4LElqw7O+oWhwNVa/p8b5pIQU+ltj0y4MtBil8x/DdlDoK');
            audio.volume = 0.3;
            audio.play().catch(err => console.log('Audio play prevented:', err));
        } catch (err) {
            console.log('Audio not supported');
        }
    }
}

/**
 * Add timestamp to footer showing when page was loaded
 */
function addLoadTimestamp() {
    const footer = document.querySelector('.retro-footer .footer-content');

    if (footer) {
        const timestamp = document.createElement('p');
        timestamp.className = 'footer-text neon-lime';
        timestamp.textContent = `⏰ Page loaded: ${new Date().toLocaleString()} ⏰`;
        timestamp.style.fontSize = '12px';
        footer.appendChild(timestamp);
    }
}

// ============================================
// ACCESSIBILITY ENHANCEMENTS
// ============================================

/**
 * Add skip-to-main-content link for keyboard users
 */
function addSkipLink() {
    const skipLink = document.createElement('a');
    skipLink.href = '#main';
    skipLink.className = 'skip-link';
    skipLink.textContent = 'Skip to main content';

    document.body.insertBefore(skipLink, document.body.firstChild);
}

/**
 * Ensure all external links have proper attributes
 */
function enhanceExternalLinks() {
    const links = document.querySelectorAll('a[href^="http"]');

    links.forEach(link => {
        // Add target="_blank" for external links
        if (!link.getAttribute('target')) {
            link.setAttribute('target', '_blank');
        }

        // Add rel="noopener noreferrer" for security
        const rel = link.getAttribute('rel') || '';
        if (!rel.includes('noopener')) {
            link.setAttribute('rel', rel + ' noopener noreferrer');
        }

        // Add visual indicator for screen readers
        const srText = document.createElement('span');
        srText.textContent = ' (opens in new tab)';
        srText.style.position = 'absolute';
        srText.style.left = '-10000px';
        srText.setAttribute('aria-label', 'opens in new tab');
        link.appendChild(srText);
    });
}

// ============================================
// INITIALIZATION
// ============================================

/**
 * Initialize all functionality when DOM is ready
 */
document.addEventListener('DOMContentLoaded', function() {
    console.log('🌐 Geocities Revival - AI DAI Homepage Loaded! 🌐');

    // Initialize hit counter
    const hitCounter = new HitCounter();
    console.log(`Hit count: ${hitCounter.get()}`);

    // Initialize smooth scroll
    initSmoothScroll();

    // Add fun effects
    addSparkleEffect();
    initKonamiCode();
    addLoadTimestamp();

    // Accessibility enhancements
    addSkipLink();
    enhanceExternalLinks();

    // Log ready state
    console.log('✅ All features initialized');
    console.log('💡 Try the Konami Code: ↑↑↓↓←→←→BA');
});

// ============================================
// DEBUGGING UTILITIES (Development Only)
// ============================================

/**
 * Expose hit counter to window for debugging
 * Usage in console: window.aidaiCounter.reset()
 */
if (typeof window !== 'undefined') {
    window.addEventListener('DOMContentLoaded', () => {
        window.aidaiCounter = new HitCounter();
        console.log('Debug: Access hit counter via window.aidaiCounter');
    });
}

// ============================================
// ERROR HANDLING
// ============================================

/**
 * Global error handler
 */
window.addEventListener('error', function(e) {
    console.error('JavaScript Error:', e.message);
    // Don't alert users in production, just log to console
});

/**
 * Handle localStorage quota exceeded errors
 */
window.addEventListener('storage', function(e) {
    if (e.key === 'aidai_hit_count') {
        console.log('Hit counter updated in another tab');
    }
});
