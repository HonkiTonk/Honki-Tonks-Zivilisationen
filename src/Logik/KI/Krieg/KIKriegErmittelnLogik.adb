with DiplomatieDatentypen;
with SpeziesKonstanten;

with LeseDiplomatie;

package body KIKriegErmittelnLogik is

   function IstImKrieg
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           SpeziesSchleifenwert = SpeziesExtern
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           DiplomatieDatentypen.Krieg_Enum = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                                              SpeziesZweiExtern => SpeziesSchleifenwert)
         then
            return True;
                  
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return False;
      
   end IstImKrieg;
   
   
   
   function KriegAnfangen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spezies_Enum
   is begin
      
      case
        SpeziesExtern
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            return SpeziesKonstanten.LeerSpezies;
            
         when others =>
            null;
      end case;
      
      SpeziesGewählt := SpeziesKonstanten.LeerSpezies;
      Bewertungen := (others => 0);
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           SpeziesSchleifenwert = SpeziesExtern
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         else
            SpeziesGewählt := StärkeVerhältnisErmitteln (EigeneSpeziesExtern => SpeziesExtern,
                                                            FremdeSpeziesExtern => SpeziesSchleifenwert);
         end if;
         
      end loop SpeziesSchleife;
      
      return SpeziesGewählt;
      
   end KriegAnfangen;
   
   
   
   function StärkeVerhältnisErmitteln
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      FremdeSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return SpeziesDatentypen.Spezies_Enum
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Bewertung := 0;
      
      if
        EigeneSpeziesExtern = FremdeSpeziesExtern
      then
         null;
         
      else
         Bewertung := 1;
      end if;
      
      if
        Bewertung > NotwendigeBewertung (EigeneSpeziesExtern)
      then
         null;
         
      else
         return SpeziesKonstanten.LeerSpezies;
      end if;
      
      if
        SpeziesGewählt = SpeziesKonstanten.LeerSpezies
      then
         Bewertungen (FremdeSpeziesExtern) := Bewertung;
         
      elsif
        Bewertungen (SpeziesGewählt) < Bewertung
      then
         Bewertungen (FremdeSpeziesExtern) := Bewertung;
         Bewertungen (SpeziesGewählt) := 0;
         
      else
         null;
      end if;
      
      return FremdeSpeziesExtern;
      
   end StärkeVerhältnisErmitteln;

end KIKriegErmittelnLogik;
