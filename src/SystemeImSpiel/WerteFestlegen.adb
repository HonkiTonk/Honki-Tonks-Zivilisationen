package body WerteFestlegen is

   function StadtumgebungsgrößeFestlegen (Rasse, Stadtnummer : in Integer) return Integer is
   begin
      
      if GlobaleVariablen.Wichtiges (GlobaleVariablen.Rasse).Erforscht (5) /= '0' and GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).Einwohner >= 10 then
         return 2;

      elsif GlobaleVariablen.Wichtiges (GlobaleVariablen.Rasse).Erforscht (10) /= '0' and GlobaleVariablen.StadtGebaut (GlobaleVariablen.Rasse, Stadtnummer).Einwohner >= 20 then
         return 3;
                  
      else
         return 1;
      end if;
      
   end StadtumgebungsgrößeFestlegen;

end WerteFestlegen;
