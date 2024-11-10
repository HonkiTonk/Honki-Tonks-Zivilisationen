package body KommazahltestsHTB2 is
   
   function Strichrechnung
     (GrundwertExtern : in Kommazahl;
      ZusatzwertExtern : in Kommazahl)
      return Kommazahl
   is begin
      
      if
        ZusatzwertExtern > 0.00
        and then
          GrundwertExtern > Kommazahl'Last - ZusatzwertExtern
      then
         return Kommazahl'Last;
         
      elsif
        ZusatzwertExtern < 0.00
        and then
          GrundwertExtern < Kommazahl'First - ZusatzwertExtern
      then
         return Kommazahl'First;
         
      else
         null;
      end if;
      
      return GrundwertExtern + ZusatzwertExtern;
      
   end Strichrechnung;
   
   
   
   function StrichrechnungNatural
     (GrundwertExtern : in Kommazahl;
      ZusatzwertExtern : in Kommazahl)
      return Kommazahl
   is begin
      
      if
        ZusatzwertExtern > 0.00
      then
         if
           GrundwertExtern > Kommazahl'Last - ZusatzwertExtern
         then
            return Kommazahl'Last;
         
         elsif
           GrundwertExtern + ZusatzwertExtern < 0.00
         then
            return 0.00;
            
         else
            null;
         end if;
         
      elsif
        ZusatzwertExtern < 0.00
        and then
          GrundwertExtern < 0.00 - ZusatzwertExtern
      then
         return 0.00;
      
      else
         null;
      end if;
      
      return GrundwertExtern + ZusatzwertExtern;
      
   end StrichrechnungNatural;
   
   
   
   function StrichrechnungPositive
     (GrundwertExtern : in Kommazahl;
      ZusatzwertExtern : in Kommazahl)
      return Kommazahl
   is begin
      
      if
        ZusatzwertExtern > 0.00
      then
         if
           GrundwertExtern > Kommazahl'Last - ZusatzwertExtern
         then
            return Kommazahl'Last;
         
         elsif
           GrundwertExtern + ZusatzwertExtern < 1.00
         then
            return 1.00;
            
         else
            null;
         end if;
         
      elsif
        ZusatzwertExtern < 0.00
        and then
          GrundwertExtern < 1.00 - ZusatzwertExtern
      then
         return 1.00;
         
      else
         null;
      end if;
      
      return GrundwertExtern + ZusatzwertExtern;
      
   end StrichrechnungPositive;
   
   

   function Multiplikation
     (GrundwertExtern : in Kommazahl;
      MultiplikatorExtern : in Kommazahl)
      return Kommazahl
   is begin
      
      if
        MultiplikatorExtern /= 0.00
      then
         if
           GrundwertExtern > Kommazahl'Last / MultiplikatorExtern
         then
            return Kommazahl'Last;
            
         elsif
           GrundwertExtern < Kommazahl'First / MultiplikatorExtern
         then
            return Kommazahl'First;
         
         else
            null;
         end if;
         
      else
         null;
      end if;
      
      return GrundwertExtern * MultiplikatorExtern;
      
   end Multiplikation;

end KommazahltestsHTB2;
