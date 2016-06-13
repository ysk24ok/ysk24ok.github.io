---
layout: default
title: Home
---

<div class="post-list">
{% for post in site.posts %}
<div class="post-item">
  <h1><a href="{{ post.url }}">{{ post.title }}</a></h1>
  <ul class="post-tags">
    {% for tag in post.tags %}
      <li><a href="#">{{ tag }}</a></li>
    {% endfor %}
  </ul>
  <div class="post-date">posted on {{ post.date | date_to_string }}</div>
  <hr>
  </div>
{% endfor %}
</div>
