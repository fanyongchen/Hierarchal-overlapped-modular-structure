function [FEC,FE,Clus_num,Clus_size,cluster_id] = Functional_HP2(data,N)
%%%%%%%%%%%%%%
%%�˺���ͨ������ÿһ������ֵ��Ӧ����������������������ģ��
%%OUTPUT��Clus_num, ÿ��ģ��������ڵ����ı�ֵ
%         Clus_size  ÿһ������Ľڵ����
%         cluster_id ����ڵ�id;

cluster_id = cell(N,N);
[V,D]=eig(data); %FEC����������FE����ֵ
[~,ind] = sort(diag(D),'descend'); %������ֵ���������У�����������
FE = D(ind,ind);
FEC = V(:,ind);
% FEC=fliplr(FEC); %�������������з�ת
H1_1=find(FEC(:,1)<0);
H1_2=find(FEC(:,1)>=0);
eval(['cluster_id{1,1}','=', 'H1_1', ';'])
eval(['cluster_id{1,2}','=', 'H1_2', ';'])
%%%%==============================================================
Clus_num=[1];%% number of cluster size 
Clus_size=cell(N,1);
for mode=2:N
    x=find(FEC(:,mode)>=0);
    y=find(FEC(:,mode)<0);
    H={};
    for j=1:2*Clus_num(mode-1)
        H{j}=eval(['H',num2str(mode-1),'_',num2str(j)]);%% assume the number of cluster in j-1 level is 2^(mode-1) %eval ������ʾִ���ı��е�Matlab���ʽ
    end
    id = cellfun('length',H);%% length of each cluster in H
    H(id==0)=[];%% delete the cluster with 0 size
    id(id==0)=[];
    Clus_size{mode-1}=id;
    Clus_num=[Clus_num,length(H)];%% number of cluster
    k=1; 
    for j=1:2:2*Clus_num(mode)%ģ������
         Positive_Node=intersect(H{k},x);
         Negtive_Node=intersect(H{k},y);         
         k=k+1;
         eval(['H',num2str(mode),'_',num2str(j+1), '=', 'Positive_Node', ';'])
         eval(['H',num2str(mode),'_',num2str(j), '=', 'Negtive_Node', ';'])
         eval(['cluster_id{',num2str(mode),',',num2str(j+1), '}=', 'Positive_Node', ';'])
         eval(['cluster_id{',num2str(mode),',',num2str(j), '}=', 'Negtive_Node', ';'])
    end  
    for j=1:2*Clus_num(mode-1)%ģ������
         eval(['clear',' H',num2str(mode-1),'_',num2str(j),'']);
    end
%      Z=[];
    if (Clus_num(end)==N)
%         for j=1:2*Clus_num(mode)
%             Z=[Z;eval(['H',num2str(mode),'_',num2str(j)])];
%         end
        break;
    end
end
Clus_num(1)=[];
Clus_num=[Clus_num/N,ones(1,N-length(Clus_num))];
% FC=zeros(N,N);
% for i=1:N
%     for j=1:N
%         FC(i,j)=data(Z(i),Z(j));
%     end
% end
end