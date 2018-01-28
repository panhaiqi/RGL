function [result]= slkessemi(K,y,alpha,beta,mu,E,Y1,Y2,Z,k,distX1,r)  %K大概是我们的X？
 %beta = betalist(jj);

 [gamma] = cal_gamma(K,distX1,beta,k);
% for ij = 1:length(mulist)
 %mu= mulist(ij);
 %disp([alpha,beta,mu])
 for i = 1:200
     D =  updateD(E,K,Y1,Y2,mu,Z,gamma);
     distX = L2_distance_1(D,D);
     [distX1, idx] = sort(distX,2);
     [gamma] = cal_gamma(D,distX1,beta,k);
     E = updateE(D,E,K,Y1,mu,alpha);
     S = updateS(K,distX1,idx,k,gamma,beta);
     S=(S+S')/2;
     L = diag(sum(S))-S;
     Z = updateZ(L,beta,mu,D,Y2);
     Y1 = Y1+mu*(D+E-K);
     Y2 = Y2+mu*(D-Z);
     mu=mu*1.1;
 end

L=(S+S')/2;

%loop
%for r = 0.1:0.1
% dlmwrite(filename,r,'-append','delimiter','\t','newline','pc');
for it = 1:20

        [m,n]=size(K);
        c=length(unique(y)); % number of class
        numperc=floor(n/c); % number of data per class
        labelperc = floor(r*numperc); % number of labeled data per class
        labelindperc = sort(randperm(numperc,labelperc)); % index of labeled data selected
        labelind = []; % labelind: index of known label
        for i = 1:c
            labelind = [labelind labelindperc+(i-1)*numperc];
        end
        ulabel = setdiff(1:n,labelind);%index of unlabeled data
        %sync notation
        mm = length(labelind);
        labels = zeros(mm, c);
        for i = 1:mm
            labels(i,y(labelind(i))) = 1;
        end
        known_nodes = labelind;
        nodes_to_predict = ulabel;
        options.alpha = 0.99;
        %label
        if ~isfield(options, 'alpha')
            options.alpha = 0.99;
        end
        if ~isfield(options, 'precision')
            options.precision = 1e-5;
        end
        if ~isfield(options, 'maxiter')
            options.maxiter = 100;
        end

        [n, m] = size(L);

        if n ~= m
            error('label_diffusion:A_square', 'Adjacency matrix must be square');
        end
        if options.alpha <= 0 || options.alpha >= 1
            error('label_diffusion:alpha_range', 'alpha must belong to ]0,1[');
        end

        % Normalization of the adjacency matrix
        D = diag(sum(L,2).^(-0.5));
        diffusion_matrix = D*L*D;

        k = size(labels, 2);
        ini_scores = zeros(n, k);
        ini_scores(known_nodes, :) = labels;
        predictions_score = ini_scores;

        % Propagation
        for i=1:options.maxiter
            last_score = predictions_score;
            predictions_score = options.alpha*diffusion_matrix*predictions_score + (1-options.alpha)*ini_scores;
            if max(max(abs(last_score-predictions_score))) < options.precision
                break;
            end
        end

        % keep only predictions for nodes specified by 'nodes_to_predict'
        predictions_score = predictions_score(nodes_to_predict, :);

        % calculate accuracy
        [ur,uc]=size(ulabel);
        [max_value,max_ind] = max(predictions_score,[],2);
        cnt = 0;
        for i = 1:uc
            if max_ind(i) == y(ulabel(i))
                cnt = cnt+1;
            end
        end
        result(it) = cnt/uc;
        
        %dlmwrite(filename,[result(it)],'-append','delimiter','\t','newline','pc');
end

   
%end

