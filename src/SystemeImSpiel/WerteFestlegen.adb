package body WerteFestlegen is

   function StadtumgebungsgrößeFestlegen (Rasse, Stadtnummer : in Integer) return Integer is
   begin
      
      if GlobaleVariablen.Wichtiges (Rasse).Erforscht (5) /= '0' and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).Einwohner >= 10 then
         return 2;

      elsif GlobaleVariablen.Wichtiges (Rasse).Erforscht (10) /= '0' and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).Einwohner >= 20 then
         return 3;
                  
      else
         return 1;
      end if;
      
   end StadtumgebungsgrößeFestlegen;

end WerteFestlegen;
