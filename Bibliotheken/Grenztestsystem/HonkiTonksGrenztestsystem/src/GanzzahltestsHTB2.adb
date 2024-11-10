package body GanzzahltestsHTB2 is

   function Strichrechnung
     (GrundwertExtern : in GanzeZahl;
      ZusatzwertExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      if
        ZusatzwertExtern > 0
        and then
          GrundwertExtern > GanzeZahl'Last - ZusatzwertExtern
      then
         return GanzeZahl'Last;
         
      elsif
        ZusatzwertExtern < 0
        and then
          GrundwertExtern < GanzeZahl'First - ZusatzwertExtern
      then
         return GanzeZahl'First;
         
      else
         null;
      end if;
      
      return GrundwertExtern + ZusatzwertExtern;
      
   end Strichrechnung;
   
   
   
   function StrichrechnungNatural
     (GrundwertExtern : in GanzeZahl;
      ZusatzwertExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      if
        ZusatzwertExtern > 0
      then
         if
           GrundwertExtern > GanzeZahl'Last - ZusatzwertExtern
         then
            return GanzeZahl'Last;
         
         elsif
           GrundwertExtern + ZusatzwertExtern < 0
         then
            return 0;
            
         else
            null;
         end if;
         
      elsif
        ZusatzwertExtern < 0
        and then
          GrundwertExtern < 0 - ZusatzwertExtern
      then
         return 0;
      
      else
         null;
      end if;
      
      return GrundwertExtern + ZusatzwertExtern;
      
   end StrichrechnungNatural;
   
   
   
   function StrichrechnungPositive
     (GrundwertExtern : in GanzeZahl;
      ZusatzwertExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      if
        ZusatzwertExtern > 0
      then
         if
           GrundwertExtern > GanzeZahl'Last - ZusatzwertExtern
         then
            return GanzeZahl'Last;
         
         elsif
           GrundwertExtern + ZusatzwertExtern < 1
         then
            return 1;
            
         else
            null;
         end if;
         
      elsif
        ZusatzwertExtern < 0
        and then
          GrundwertExtern < 1 - ZusatzwertExtern
      then
         return 1;
         
      else
         null;
      end if;
      
      return GrundwertExtern + ZusatzwertExtern;
      
   end StrichrechnungPositive;
   
   
   
   function Multiplikation
     (GrundwertExtern : in GanzeZahl;
      MultiplikatorExtern : in GanzeZahl)
      return GanzeZahl
   is begin
      
      case
        MultiplikatorExtern
      is
         when 0 =>
            null;
            
         when others =>
            if
              GrundwertExtern > GanzeZahl'Last / MultiplikatorExtern
            then
               return GanzeZahl'Last;
            
            elsif
              GrundwertExtern < GanzeZahl'First / MultiplikatorExtern
            then
               return GanzeZahl'First;
         
            else
               null;
            end if;
      end case;
      
      return GrundwertExtern * MultiplikatorExtern;
      
   end Multiplikation;

end GanzzahltestsHTB2;
