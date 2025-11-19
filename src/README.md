Task 1:
    studio.m :
     Diferenta "Plain loop" cu "Plain sound" :
        In "Plain loop" semnalele sunt continue (frecventele din graf nu sunt intrerupte);
        In "Plain sound", fiecare semnal pare sa fie intrerupt

     Diferenta "Plain sound" cu "Low Pass sound" :
        In "Low Pass sound", semnalele (frecventele) par sa fie periodice dupa un anumit interval de timp, extrage doar semnalele joase
        In "Plain sound", fiecare frecventa arata diferit una fata
        de cealalta (uneori semnalul apare mai puternic, alteori semnalul are o perioada de timp mai lunga)

     Diferenta "Plain sound" si "Reverb Sound" :
        "Reverb Sound" - a preluat elementele din "Plain Sound", le-am multiplicat si a produs un semnal continuu, a transformat semnalul initial
        intr-un "ecou"

     "Tech" : 

     "LowPass + Tech" : preia semnalul din "Tech" si extrage doar semnalele care nu trec de o anumita frecventa (preia doar frecventele joase)

     "Reverb + Tech" : preia semnalul din "Tech" si il amplifica, creaza un efect de ecou din semnalul initial

     "Low Pass + Reverb Tech" : preia semnalul din "Reverb + Tech" si selecteaza doar frecventele joase in semnal

     "Reverb + LowPass Tech" : preia semnalul din "LowPass + Tech" si amplifica semnalul, creand efectul de ecou (semnalul produs este asemanator cu 
     cel din "Low Pass + Reverb Tech")

     stereo_to_mono : 
        - am preluat semnalul original "signal" si am returnat un vector coloana, folosind formula din enunt, pe care am normalizat-o
    
     spectogram :
        - am calculat lungimea semnalului original
        - am calculat numarul de "ferestre", folosind lungimea semnalului impartit la dimensiunea unei ferestre ( am folosit functia "floor" definita de matlab)
        - hn -> salveaza rezultatul functiei hann (definita in matlab) asupra parametrului window_size
        - am creat vectorul de frecvente ( am selectat doar prima parte din matricea originala )
        - am creat vectorul de timp (timpul este egal cu numarul de ferestre impartit la frecventa 'fs')
        - am inmultit fiecare fereasta (si fiecare element din vector) cu variabila hn, iar apoi am aplicat functia Fourier, cu o rezolutie de doua ori mai mare decat lungimea unei ferestre
        - am salvat rezultatul in matricea "S" (spectogram)

     oscilator : 
        - Se creează un vector de timp t care începe de la 0 și se termină la dur - 1/fs, cu un pas de 1/fs.
        - Se generează un semnal sinusoidal cu frecvența freq.
        - total_samples: Numărul total de eșantioane din semnal.
        - A_sample, D_sample, R_sample: Numărul de eșantioane pentru fazele de Attack, Decay și Release.
        - S_sample: Numărul de eșantioane pentru faza de Sustain, calculat ca diferența dintre numărul total de eșantioane și celelalte faze.
        - A_envelope: Faza de Attack, unde amplitudinea crește liniar de la 0 la 1.
        - D_envelope: Faza de Decay, unde amplitudinea scade liniar de la 1 la nivelul de Sustain S.
        - S_envelope: Faza de Sustain, unde amplitudinea rămâne constantă la nivelul S.
        - R_envelope: Faza de Release, unde amplitudinea scade liniar de la S la 0.
        - Se concatenează toate fazele pentru a forma o singură envelope completă.
        - Se aplică envelope-ul asupra semnalului sinusoidal inițial prin multiplicare element cu element și se transpune rezultatul pentru a fi un vector coloană.

     low pass : 
         - Se calculează Transformata Fourier a semnalului de intrare signal, obținându-se signal_fft, care reprezintă spectrul de frecvență al semnalului.
         - n: Numărul total de eșantioane din semnal
         - f: Vectorul de frecvențe corespunzătoare componentelor Fourier, calculat pe baza ratei de eșantionare fs și a numărului de eșantioane n.
         - mask: Un vector binar care este 1 pentru frecvențele mai mici sau egale cu cutoff_freq și 0 pentru frecvențele mai mari decât cutoff_freq. Aceasta definește filtrul trece-jos
         - filtered_fft: Se obține prin multiplicarea element cu element a transformatei Fourier originale cu masca mask. Aceasta păstrează doar componentele de frecvență sub cutoff_freq și elimină restul
         -Se aplică Transformata Fourier inversă pe filtered_fft pentru a obține semnalul filtrat în domeniul timpului, filtered_signal
         - Se normalizează semnalul filtrat astfel încât valoarea maximă absolută să fie 1. Aceasta asigură că amplitudinea semnalului filtrat este scalată corespunzător

     apply_reverb : 
        - impulse_response -> l-am transformat intr-un semnal mono
        - am aplicat functia fftconv pentru a obtine convolutia dintre semnal si impulse_response
        - am normalizat semnalul 

Task 2 : 
     parse_data : 
        - Am citit datele din fisierul primit "filename"
        - apoi am citit valoarea n, cele n + 1 valori care vor fi salvate in vectorul x si reprezinta abscisa punctele de interpolare, apoi am citit
        urmatoarele n + 1 valori care vor fi salvate in vectorul y si vor reprezenta ordonata punctelor de interpolare

     spline_c2 : 
      - Am aplicat functia de spline asupra vectorilor linie x si y creati anterior si am urmat pasii mentionati in functia descrisa

     P_spline : 
      - am preluat valorile din matricea de coeficienti determinata in functia spline_c2 si din vectorul (x_interp - x) citit si le-am salvat in matricea y_interp, sub forma unui polinom  

      vandermonde : 
      - Am creat un vector auxiliar V ca reprezinta inversa vectorului vandermonde (functie existenta in matlab)
      - coef sa obtinut prin impartirea vectorului auxiliar cu vectorul y (primit ca parametru)

      P_vandermonde :
      - functia returneaza un vector y_interp in care sunt salvate, pe fiecare coloana, functiile polinomiale determinate prin inmultirea coeficientilor determinati in functia precedenta si vectorul V auxiliar care retine valorile x(i)

Task 3 :
     cosine_similarity : 
      - am creat doi vectori norm_a si norm_b care salveaza vectorii a si b aplicand norma euclidiana
      - am determinat suma dintre fiecare element din cei doi vectori a si b
      - am determinat nivelul de asemanare impartind suma la produsul fiecarei norme calculate anterior

     preprocess : 
      - se un vector de review-uri : se face suma fiecarui element din matricea mat, pentru fiecare linie( daca valoarea din matrice este diferita de 0, atunci adauga 1, altfel se aduna cu 0)
      - vectorul de reviews -> fiecare element este egal cu 1 daca valoarea numarul de recenzii este mai mare decat numarul minim de review-ur, altfel este egal cu 0
      - reduce_mat - selecteaza din matrice mat doar userii care sunt "valid_users"

      read_mat : 
      - Citeste din fisierul "path" matricea o matrice care va fi salvata in variabila mat

      recommandations : 
      - am aplicat functia preprocess asupra matricea mat creata in functia anterioara
      - am aplicat functia svd asupra matricea mat
      - pentru fiecare element din vectorul V am aplicat functia cosine_similarity, determinata anterior
      - am returnat indicii in ordine descrescatoare (am sarit peste prima coloana)