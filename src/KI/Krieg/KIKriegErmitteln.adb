pragma SPARK_Mode (On);

with DiplomatischerZustand;

package body KIKriegErmitteln is

   function IstImKrieg
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         elsif
           DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseExtern,
                                                              FremdeRasseExtern => RasseSchleifenwert)
           = SonstigeDatentypen.Krieg
         then
            return True;
                  
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end IstImKrieg;
   
   
   
   function KriegAnfangen
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return SonstigeDatentypen.Rassen_Enum
   is begin
      
      case
        RasseExtern
      is
         when SonstigeDatentypen.Ekropa =>
            return GlobaleDatentypen.Leer;
            
         when others =>
            null;
      end case;
      
      RasseGewählt := GlobaleDatentypen.Leer;
      Bewertungen := (others => 0);
      
      RassenSchleife:
      for RasseSchleifenwert in SonstigeDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) = GlobaleDatentypen.Leer
         then
            null;
            
         else
            RasseGewählt := StärkeVerhältnisErmitteln (EigeneRasseExtern => RasseExtern,
                                                          FremdeRasseExtern => RasseSchleifenwert);
         end if;
         
      end loop RassenSchleife;
      
      return RasseGewählt;
      
   end KriegAnfangen;
   
   
   
   function StärkeVerhältnisErmitteln
     (EigeneRasseExtern, FremdeRasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
      return SonstigeDatentypen.Rassen_Enum
   is begin
      
      Bewertung := 0;
      
      if
        EigeneRasseExtern = FremdeRasseExtern
      then
         null;
         
      else
         Bewertung := 1;
      end if;
      
      if
        Bewertung > NotwendigeBewertung (EigeneRasseExtern)
      then
         null;
         
      else
         return GlobaleDatentypen.Leer;
      end if;
      
      if
        RasseGewählt = GlobaleDatentypen.Leer
      then
         Bewertungen (FremdeRasseExtern) := Bewertung;
         
      elsif
        Bewertungen (RasseGewählt) < Bewertung
      then
         Bewertungen (FremdeRasseExtern) := Bewertung;
         Bewertungen (RasseGewählt) := 0;
         
      else
         null;
      end if;
      
      return FremdeRasseExtern;
      
   end StärkeVerhältnisErmitteln;

end KIKriegErmitteln;
