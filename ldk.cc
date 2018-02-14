/*obtaining degrees from routing table*/

void AODV::rt_print(nsaddr_t nodeid) {
FILE *fp;
fp = fopen("neighbor.txt", "a");
aodv_rt_entry *rt;
for (rt=rtable.head();rt; rt = rt->rt_link.le_next) 
{
fprintf(fp, "At time %f node %i transmits in route %i with nexthop neighbor: %i seq no %i upto %f with %d \n", CURRENT_TIME, nodeid, rt->rt_dst, rt->rt_nexthop, rt->rt_seqno, rt->rt_expire, rt->rt_flags);

printf("At time %f node %i transmits in route %i with nexthop neighbor: %i seq no %i upto %f with %d \n", CURRENT_TIME, nodeid, rt->rt_dst, rt->rt_nexthop, rt->rt_seqno, rt->rt_expire, rt->rt_flags);
}
fclose(fp);
}
    

void AODV::rt_print(nsaddr_t nodeid) {
FILE *fp;
fp = fopen("degree.txt", "a");
aodv_rt_entry *rt;
for (rt=rtable.head();rt; rt = rt->rt_link.le_next) 
{
fprintf(fp, "%i  %i", nodeid,rt->rt_nexthop);
}
fclose(fp);
}


/*Implementation of LDK*/
int fact(int z)
{
    int f = 1, i;
    if (z == 0)
    {
        return(f);
    }
    else
    {
        for (i = 1; i <= z; i++)
	{
            f = f * i;
	}
    }
    return(f);
}

int i,l=1,sum=0,kci;
float prob;
if(l>k)
prob=1;
else
{
prob=0.6;
for(i=l;i<=k;i++)
 {
  kci = fact(k) / (fact(i) * fact(k - i));
  T=kci*power(prob,i)*power(1-prob,k-i);  
 }                                                     
}


