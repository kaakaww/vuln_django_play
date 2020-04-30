from django.contrib import admin

# Register your models here.

from .models import Choice, Question


class ChoiceInline(admin.TabularInline):
    model = Choice
    extra = 3


class QuestionAdmin(admin.ModelAdmin):
   fieldsets = [
       (None,                   {'fields': ['questions_text']}),
       ('Date Information',     {'fields': ['pub_date'], 'classes':
                                 ['collapse']}),
   ]
   inlines = [ChoiceInline]
   list_filter = ['pub_date']
   search_fields = ['questions_text']
   list_display = ('questions_text', 'pub_date', 'was_published_recently')


admin.site.register(Question, QuestionAdmin)
