package body HTGGrenztestsystem is
         
   function Strichrechnung
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
           GrundwertExtern < GanzeZahl'First + ZusatzwertExtern
         then
            return GanzeZahl'First;
            
         else
            null;
         end if;
         
      elsif
        ZusatzwertExtern < 0
      then
         if
           GrundwertExtern > GanzeZahl'Last + ZusatzwertExtern
         then
            return GanzeZahl'Last;
         
         elsif
           GrundwertExtern < GanzeZahl'First - ZusatzwertExtern
         then
            return GanzeZahl'First;
            
         else
            null;
         end if;
         
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
           GrundwertExtern < 0 + ZusatzwertExtern
         then
            return 0;
            
         else
            null;
         end if;
         
      elsif
        ZusatzwertExtern < 0
      then
         if
           GrundwertExtern > GanzeZahl'Last + ZusatzwertExtern
         then
            return GanzeZahl'Last;
         
         elsif
           GrundwertExtern < 0 - ZusatzwertExtern
         then
            return 0;
            
         else
            null;
         end if;
         
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
           GrundwertExtern < 1 + ZusatzwertExtern
         then
            return 1;
            
         else
            null;
         end if;
         
      elsif
        ZusatzwertExtern < 0
      then
         if
           GrundwertExtern > GanzeZahl'Last + ZusatzwertExtern
         then
            return GanzeZahl'Last;
         
         elsif
           GrundwertExtern < 1 - ZusatzwertExtern
         then
            return 1;
            
         else
            null;
         end if;
         
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
      
      if
        MultiplikatorExtern /= 0
      then
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
         
      else
         null;
      end if;
      
      return GrundwertExtern * MultiplikatorExtern;
      
   end Multiplikation;
   
   
   
   function Kommamultiplikation
     (GrundwertExtern : in KommaZahl;
      MultiplikatorExtern : in KommaZahl)
      return KommaZahl
   is begin
      
      if
        MultiplikatorExtern /= 0.00
      then
         if
           GrundwertExtern > KommaZahl'Last / MultiplikatorExtern
         then
            return KommaZahl'Last;
            
         elsif
           GrundwertExtern < KommaZahl'First / MultiplikatorExtern
         then
            return KommaZahl'First;
         
         else
            null;
         end if;
         
      else
         null;
      end if;
      
      return GrundwertExtern * MultiplikatorExtern;
      
   end Kommamultiplikation;

end HTGGrenztestsystem;
