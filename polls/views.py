from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.views import generic
from django.utils import timezone
from django.db import connection
from urllib.parse import unquote
from django.views.decorators.csrf import csrf_exempt
from .models import Choice, Question


class IndexView(generic.ListView):
    template_name = 'polls/index.html'
    context_object_name = 'latest_question_list'

    def get_queryset(self):
        """Return the last five published questions"""
        return Question.objects.filter(pub_date__lte=timezone.now()).order_by('-pub_date')[:5]


class DetailView(generic.DetailView):
    model = Question
    template_name = 'polls/detail.html'

    def get_queryset(self):
        """
        Exclude any questions that aren't published yet
        :return:
        """
        return Question.objects.filter(pub_date__lte=timezone.now())


class ResultsView(generic.DetailView):
    model = Question
    template_name = 'polls/results.html'

    def get_queryset(self):
        """
        Exclude any questions that aren't published yet
        :return:
        """
        return Question.objects.filter(pub_date__lte=timezone.now())


@csrf_exempt
def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    context = { 'latest_question_list': latest_question_list, }
    return render(request, 'polls/index.html', context)


@csrf_exempt
def detail(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'polls/results.html', {'question': question})


@csrf_exempt
def results(request, question_id):
    response = "You're looking at the results of question %s."
    return HttpResponse(response % question_id)


@csrf_exempt
def vote(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    try:
        selected_choice = question.choice_set.get(pk=request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        # redisplay the question voting form
        return render(request, 'polls/detail.html', {
            'question': question,
            'error_message': "You didn't select a choice.",
        })
    else:
        selected_choice.votes += 1
        selected_choice.save()
        # Always return an HttpResponseRedirect after successfully dealing
        # with POST data. This prevents the data from being posted twice if a
        # user hist the Back button
        return HttpResponseRedirect(reverse('polls:results', args=(question.id,)))


@csrf_exempt
def inject(request, injector_str):
    response = "You're looking at the page that handles injection of %s"
    return render(request, 'polls/injector.html', {
        'injector_str': unquote(injector_str),
    })


@csrf_exempt
def sql_injector(request, ):
    sql_str = request.GET.get('sql')
    prepared_sql = request.GET['sql']
    cursor = connection.cursor()
    cursor.execute(prepared_sql)
    sql_results = cursor.fetchall()
    cursor.close()
    return render(request, 'polls/sequeleye.html', {
        'sql_str': sql_str,
        'sql_results': sql_results,
    }) #HttpResponse("Ohh, my DB info, yeah it's here: " + str(sql_results))


@csrf_exempt
def search(request, ):
    search_str = request.POST.get('search_string', 'found nothing in search')
    return render(request, 'polls/search_detail.html', {'search_string': search_str,})
