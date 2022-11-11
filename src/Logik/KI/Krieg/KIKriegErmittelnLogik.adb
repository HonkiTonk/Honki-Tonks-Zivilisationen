with ProduktionDatentypen; use ProduktionDatentypen;
with DiplomatieDatentypen; use DiplomatieDatentypen;
with EinheitenKonstanten;

with DiplomatischerZustandLogik;

package body KIKriegErmittelnLogik is

   function IstImKrieg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           DiplomatieDatentypen.Krieg_Enum = DiplomatischerZustandLogik.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseExtern,
                                                                                                     FremdeRasseExtern => RasseSchleifenwert)
         then
            return True;
                  
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end IstImKrieg;
   
   
   
   function KriegAnfangen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Enum
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Ekropa_Enum =>
            return EinheitenKonstanten.LeerRasse;
            
         when others =>
            null;
      end case;
      
      RasseGewählt := EinheitenKonstanten.LeerRasse;
      Bewertungen := (others => 0);
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RasseSchleifenwert = RasseExtern
           or
             SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung = RassenDatentypen.Leer_Spieler_Enum
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
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Enum
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
         return EinheitenKonstanten.LeerRasse;
      end if;
      
      if
        RasseGewählt = EinheitenKonstanten.LeerRasse
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

end KIKriegErmittelnLogik;
