/**
 * ROBINSWEB - Interactive Portfolio Engine
 * Features:
 *  - Dynamic Hero Parallax & 3D Layered Scroll Effects
 *  - Floating Sliding-Pill Nav Anchor ScrollSpy
 *  - Golden Ember Canvas Particle System
 *  - Staggered Scroll-Reveal Animations
 *  - Interactive Project Filtering & Modal View
 *  - Smooth Anchor Navigation
 */

document.addEventListener('DOMContentLoaded', () => {
  // DOM Elements
  const header = document.querySelector('.site-header');
  const navPill = document.querySelector('.nav-sliding-pill');
  const navLinks = document.querySelectorAll('.nav-link-item');
  const sections = document.querySelectorAll('section[id]');
  const heroSection = document.querySelector('.hero-section');
  const heroTypography = document.querySelector('.hero-giant-typography');
  const heroPortrait = document.querySelector('.hero-portrait-wrapper');
  const heroAmbientDome = document.querySelector('.hero-ambient-dome');
  const heroBottomDeck = document.querySelector('.hero-bottom-deck');
  const heroScrollAnchor = document.getElementById('heroScrollAnchor');
  const backToTopBtn = document.getElementById('backToTopBtn');
  const mobileToggle = document.getElementById('mobileToggle');
  const mobileDrawer = document.getElementById('mobileDrawer');
  const canvas = document.getElementById('particle-canvas');

  /* ==========================================================================
     1. GOLDEN EMBER PARTICLES CANVAS
     ========================================================================== */
  if (canvas) {
    const ctx = canvas.getContext('2d');
    let width = (canvas.width = window.innerWidth);
    let height = (canvas.height = window.innerHeight);

    window.addEventListener('resize', () => {
      width = canvas.width = window.innerWidth;
      height = canvas.height = window.innerHeight;
    });

    const particles = [];
    const particleCount = 45;

    for (let i = 0; i < particleCount; i++) {
      particles.push({
        x: Math.random() * width,
        y: Math.random() * height,
        radius: Math.random() * 2 + 0.8,
        speedY: Math.random() * -0.5 - 0.1,
        speedX: (Math.random() - 0.5) * 0.3,
        alpha: Math.random() * 0.7 + 0.2,
        color: Math.random() > 0.4 ? 'rgba(255, 120, 40, ' : 'rgba(255, 200, 100, ',
      });
    }

    function animateParticles() {
      ctx.clearRect(0, 0, width, height);

      particles.forEach((p) => {
        p.y += p.speedY;
        p.x += p.speedX;

        // Reset to bottom if floated past top
        if (p.y < -10) {
          p.y = height + 10;
          p.x = Math.random() * width;
        }

        ctx.beginPath();
        ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2);
        ctx.fillStyle = p.color + p.alpha + ')';
        ctx.shadowBlur = 8;
        ctx.shadowColor = '#ff6b2b';
        ctx.fill();
      });

      requestAnimationFrame(animateParticles);
    }
    animateParticles();
  }

  /* ==========================================================================
     2. HERO SECTION SCROLL ANIMATION & 3D PARALLAX
     ========================================================================== */
  let lastScrollY = window.scrollY;
  let ticking = false;

  function updateHeroParallax(scrollY) {
    if (!heroSection) return;
    const heroRect = heroSection.getBoundingClientRect();
    
    // Only calculate when hero is in or near viewport
    if (heroRect.bottom > 0) {
      const progress = Math.min(Math.max(scrollY / 700, 0), 1);

      // Giant Typography: scales up slightly and moves downward with depth
      if (heroTypography) {
        const textY = scrollY * 0.32;
        const textScale = 1 + progress * 0.12;
        const textOpacity = 1 - progress * 0.85;
        heroTypography.style.transform = `translate(-50%, calc(-58% + ${textY}px)) scale(${textScale})`;
        heroTypography.style.opacity = textOpacity.toString();
      }

      // Hero Portrait: moves at a different parallax speed for true 3D separation
      if (heroPortrait) {
        const portraitY = scrollY * 0.18;
        const portraitScale = 1 + progress * 0.05;
        heroPortrait.style.transform = `translateY(${portraitY}px) scale(${portraitScale})`;
      }

      // Hero Ambient Dome: scales & fades
      if (heroAmbientDome) {
        heroAmbientDome.style.transform = `translateX(-50%) scale(${1 + progress * 0.4}) translateY(${scrollY * 0.1}px)`;
        heroAmbientDome.style.opacity = (0.45 * (1 - progress * 0.5)).toString();
      }

      // Bottom Deck (Buttons & Ratings Card): gently fades and floats down
      if (heroBottomDeck) {
        const deckY = scrollY * 0.12;
        const deckOpacity = 1 - progress * 1.2;
        heroBottomDeck.style.transform = `translateY(${deckY}px)`;
        heroBottomDeck.style.opacity = Math.max(0, deckOpacity).toString();
      }

      // Hero Scroll Anchor: floats down and smoothly fades as user scrolls
      if (heroScrollAnchor) {
        const anchorY = scrollY * 0.22;
        const anchorOpacity = 1 - Math.min(scrollY / 250, 1);
        heroScrollAnchor.style.transform = `translateY(${anchorY}px)`;
        heroScrollAnchor.style.opacity = Math.max(0, anchorOpacity).toString();
      }
    }
  }

  // Mouse tilt effect on Hero Stage for desktop interactive depth
  const heroStage = document.querySelector('.hero-stage-container');
  if (heroStage && window.innerWidth > 900) {
    heroStage.addEventListener('mousemove', (e) => {
      const rect = heroStage.getBoundingClientRect();
      const x = (e.clientX - rect.left) / rect.width - 0.5;
      const y = (e.clientY - rect.top) / rect.height - 0.5;

      if (heroPortrait) {
        heroPortrait.style.transform = `translate(${x * 18}px, ${y * 12}px)`;
      }
      if (heroTypography) {
        heroTypography.style.transform = `translate(calc(-50% + ${x * -12}px), calc(-58% + ${y * -8}px))`;
      }
    });

    heroStage.addEventListener('mouseleave', () => {
      if (heroPortrait) heroPortrait.style.transform = `translate(0px, 0px)`;
      if (heroTypography) heroTypography.style.transform = `translate(-50%, -58%)`;
    });
  }

  /* ==========================================================================
     3. ANCHOR ANIMATE WHILE SCROLL (SCROLLSPY SLIDING PILL)
     ========================================================================== */
  function moveNavPill(activeItem) {
    if (!navPill || !activeItem) return;
    const parentRect = activeItem.parentElement.parentElement.getBoundingClientRect();
    const itemRect = activeItem.getBoundingClientRect();

    const left = itemRect.left - parentRect.left;
    const width = itemRect.width;

    navPill.style.transform = `translateX(${left}px)`;
    navPill.style.width = `${width}px`;
    navPill.classList.add('visible');
  }

  function updateScrollSpy() {
    const scrollPos = window.scrollY + 200; // Trigger line offset
    let currentSectionId = '';

    sections.forEach((section) => {
      const top = section.offsetTop;
      const height = section.offsetHeight;
      if (scrollPos >= top && scrollPos < top + height) {
        currentSectionId = section.getAttribute('id');
      }
    });

    // If near the top, highlight "About" or keep subtle
    if (window.scrollY < 400) {
      currentSectionId = 'about';
    }

    let matchedItem = null;
    navLinks.forEach((item) => {
      const link = item.querySelector('a');
      const href = link.getAttribute('href').replace('#', '');

      if (href === currentSectionId) {
        item.classList.add('active');
        matchedItem = item;
      } else {
        item.classList.remove('active');
      }
    });

    if (matchedItem) {
      moveNavPill(matchedItem);
    }
  }

  // Smooth click scroll to anchor
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener('click', function (e) {
      const targetId = this.getAttribute('href');
      if (targetId === '#') return;

      const targetElem = document.querySelector(targetId);
      if (targetElem) {
        e.preventDefault();
        const headerOffset = 90;
        const elemPosition = targetElem.getBoundingClientRect().top;
        const offsetPosition = elemPosition + window.pageYOffset - headerOffset;

        window.scrollTo({
          top: offsetPosition,
          behavior: 'smooth',
        });

        // Close mobile drawer if open
        if (mobileDrawer && mobileDrawer.classList.contains('open')) {
          mobileDrawer.classList.remove('open');
        }
      }
    });
  });

  // Init nav position
  setTimeout(() => {
    updateScrollSpy();
  }, 150);

  /* ==========================================================================
     4. HEADER SCROLL & BACK TO TOP BUTTON
     ========================================================================== */
  window.addEventListener('scroll', () => {
    const scrollY = window.scrollY;

    // Header styling on scroll
    if (scrollY > 50) {
      header.classList.add('scrolled');
    } else {
      header.classList.remove('scrolled');
    }

    // Back to top button visibility
    if (backToTopBtn) {
      if (scrollY > 600) {
        backToTopBtn.classList.add('visible');
      } else {
        backToTopBtn.classList.remove('visible');
      }
    }

    // Throttled scroll updates for performance
    if (!ticking) {
      window.requestAnimationFrame(() => {
        updateHeroParallax(scrollY);
        updateScrollSpy();
        ticking = false;
      });
      ticking = true;
    }
  });

  if (backToTopBtn) {
    backToTopBtn.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  /* ==========================================================================
     5. MOBILE NAVIGATION TOGGLE
     ========================================================================== */
  if (mobileToggle && mobileDrawer) {
    mobileToggle.addEventListener('click', () => {
      mobileDrawer.classList.toggle('open');
      const isOpen = mobileDrawer.classList.contains('open');
      mobileToggle.innerHTML = isOpen ? '✕' : '☰';
    });
  }

  /* ==========================================================================
     6. SCROLL REVEAL (INTERSECTION OBSERVER)
     ========================================================================== */
  const revealElements = document.querySelectorAll('.reveal-on-scroll');
  const revealObserver = new IntersectionObserver(
    (entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('revealed');
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.15, rootMargin: '0px 0px -40px 0px' }
  );

  revealElements.forEach((el) => revealObserver.observe(el));

  /* ==========================================================================
     7. PROJECT FILTERING LOGIC
     ========================================================================== */
  const filterBtns = document.querySelectorAll('.filter-btn');
  const projectCards = document.querySelectorAll('.project-card');

  filterBtns.forEach((btn) => {
    btn.addEventListener('click', () => {
      filterBtns.forEach((b) => b.classList.remove('active'));
      btn.classList.add('active');

      const filter = btn.getAttribute('data-filter');

      projectCards.forEach((card) => {
        const category = card.getAttribute('data-category');
        if (filter === 'all' || category === filter) {
          card.style.display = 'block';
          setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
          }, 50);
        } else {
          card.style.opacity = '0';
          card.style.transform = 'translateY(15px)';
          setTimeout(() => {
            card.style.display = 'none';
          }, 300);
        }
      });
    });
  });

  /* ==========================================================================
     8. INTERACTIVE CONTACT FORM & TOAST
     ========================================================================== */
  const budgetChips = document.querySelectorAll('.budget-chip');
  budgetChips.forEach((chip) => {
    chip.addEventListener('click', () => {
      budgetChips.forEach((c) => c.classList.remove('active'));
      chip.classList.add('active');
    });
  });

  const contactForm = document.getElementById('projectContactForm');
  const formToast = document.getElementById('formToast');

  if (contactForm && formToast) {
    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const submitBtn = contactForm.querySelector('.btn-submit-form');
      const originalText = submitBtn.innerHTML;

      submitBtn.innerHTML = 'Sending Enquiry...';
      submitBtn.style.opacity = '0.7';

      setTimeout(() => {
        submitBtn.innerHTML = 'Sent Successfully! ✓';
        submitBtn.style.background = '#28a745';
        submitBtn.style.borderColor = '#28a745';

        // Show Toast
        formToast.classList.add('show');
        setTimeout(() => {
          formToast.classList.remove('show');
          submitBtn.innerHTML = originalText;
          submitBtn.style.background = '';
          submitBtn.style.borderColor = '';
          submitBtn.style.opacity = '1';
          contactForm.reset();
        }, 4000);
      }, 1200);
    });
  }

  // Smooth hover sound/feel micro-interactions
  document.querySelectorAll('.project-card, .portfolio-item-card, .software-card, .btn-primary-pill, .btn-glass-pill').forEach((el) => {
    el.addEventListener('mouseenter', () => {
      el.style.willChange = 'transform';
    });
  });

  /* ==========================================================================
     9. FULL-SCREEN LIGHTBOX MODAL SYSTEM
     ========================================================================== */
  const lightbox = document.getElementById('portfolioLightbox');
  const lightboxImg = document.getElementById('lightboxImg');
  const lightboxCat = document.getElementById('lightboxCat');
  const lightboxTitle = document.getElementById('lightboxTitle');
  const lightboxDesc = document.getElementById('lightboxDesc');
  const lightboxClose = document.getElementById('lightboxClose');
  const lightboxPrev = document.getElementById('lightboxPrev');
  const lightboxNext = document.getElementById('lightboxNext');
  const lightboxBackdrop = document.querySelector('.lightbox-backdrop');

  const galleryItems = Array.from(document.querySelectorAll('.portfolio-item-card, .project-card'));
  let currentLightboxIndex = 0;

  function openLightbox(index) {
    if (!lightbox || index < 0 || index >= galleryItems.length) return;
    currentLightboxIndex = index;
    const card = galleryItems[index];

    const img = card.querySelector('.portfolio-item-img, .project-thumb');
    const title = card.querySelector('.portfolio-item-title, .project-title');
    const desc = card.querySelector('.portfolio-item-meta, .project-subtitle');
    const badge = card.querySelector('.portfolio-item-badge, .project-overlay-badge, .project-category-tag');

    if (img && lightboxImg) {
      lightboxImg.src = img.src;
      lightboxImg.alt = img.alt || 'Portfolio Showcase';
    }

    if (lightboxTitle) lightboxTitle.textContent = title ? title.textContent : '';
    if (lightboxDesc) lightboxDesc.textContent = desc ? desc.textContent : '';
    if (lightboxCat) lightboxCat.textContent = badge ? badge.textContent.replace('✦', '').trim() : 'Portfolio';

    lightbox.classList.add('active');
    lightbox.setAttribute('aria-hidden', 'false');
    document.body.style.overflow = 'hidden';
  }

  function closeLightbox() {
    if (!lightbox) return;
    lightbox.classList.remove('active');
    lightbox.setAttribute('aria-hidden', 'true');
    document.body.style.overflow = '';
  }

  function showNextImage() {
    const nextIndex = (currentLightboxIndex + 1) % galleryItems.length;
    openLightbox(nextIndex);
  }

  function showPrevImage() {
    const prevIndex = (currentLightboxIndex - 1 + galleryItems.length) % galleryItems.length;
    openLightbox(prevIndex);
  }

  galleryItems.forEach((card, index) => {
    card.addEventListener('click', (e) => {
      // If clicking on external case study link directly, let it open
      if (e.target.closest('a')) return;
      openLightbox(index);
    });
  });

  if (lightboxClose) lightboxClose.addEventListener('click', closeLightbox);
  if (lightboxBackdrop) lightboxBackdrop.addEventListener('click', closeLightbox);
  if (lightboxNext) lightboxNext.addEventListener('click', (e) => { e.stopPropagation(); showNextImage(); });
  if (lightboxPrev) lightboxPrev.addEventListener('click', (e) => { e.stopPropagation(); showPrevImage(); });

  window.addEventListener('keydown', (e) => {
    if (!lightbox || !lightbox.classList.contains('active')) return;
    if (e.key === 'Escape') closeLightbox();
    if (e.key === 'ArrowRight') showNextImage();
    if (e.key === 'ArrowLeft') showPrevImage();
  });
});
