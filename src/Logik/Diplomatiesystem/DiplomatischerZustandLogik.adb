pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with WichtigesKonstanten;
with ZahlenDatentypen;
with TextnummernKonstanten;

with JaNeinLogik;

package body DiplomatischerZustandLogik is

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
   is begin
      
      SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand := NeuerStatusExtern;
      SpielVariablen.Diplomatie (RasseZweiExtern, RasseEinsExtern).AktuellerZustand := NeuerStatusExtern;
      
      SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung := 0;
      SpielVariablen.Diplomatie (RasseZweiExtern, RasseEinsExtern).ZeitSeitLetzterÄnderung := 0;
            
      case
        NeuerStatusExtern
      is
         when DiplomatieDatentypen.Krieg_Enum =>
            SympathieÄndern (EigeneRasseExtern => RasseEinsExtern,
                              FremdeRasseExtern => RasseZweiExtern,
                              ÄnderungExtern   => -30);
            SympathieÄndern (EigeneRasseExtern => RasseZweiExtern,
                              FremdeRasseExtern => RasseEinsExtern,
                              ÄnderungExtern   => -30);
            
         when others =>
            null;
      end case;
      
   end DiplomatischenStatusÄndern;



   function DiplomatischenStatusPrüfen
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return DiplomatieDatentypen.Status_Untereinander_Enum
   is begin
      
      return SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuellerZustand;
      
   end DiplomatischenStatusPrüfen;
   
   
   
   function DiplomatischerStatusLetzteÄnderung
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Natural
   is begin
      
      return SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).ZeitSeitLetzterÄnderung;
      
   end DiplomatischerStatusLetzteÄnderung;
   
   
   
   function AktuelleSympathie
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return DiplomatieDatentypen.Meinung
   is begin
      
      return SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung;
      
   end AktuelleSympathie;
   
   
   
   procedure SympathieÄndern
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in DiplomatieDatentypen.Meinung)
   is begin
      
      if
        SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung + ÄnderungExtern > SympathieGrenzen (DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                                                                                                                                       FremdeRasseExtern => FremdeRasseExtern))
      then
         SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung := SympathieGrenzen (DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                                                                                                                       FremdeRasseExtern => FremdeRasseExtern));
         
      elsif
        SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung + ÄnderungExtern < DiplomatieDatentypen.Meinung'First
      then
         SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung := DiplomatieDatentypen.Meinung'First;
                                                                                                                            
      else
         SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung := SpielVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung + ÄnderungExtern;
      end if;
      
   end SympathieÄndern;



   function GegnerAngreifen
     (EigeneRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                     FremdeRasseExtern => GegnerischeRasseExtern)
      is
         when DiplomatieDatentypen.Neutral_Enum =>
            if
              SpielVariablen.Diplomatie (EigeneRasseExtern, GegnerischeRasseExtern).ZeitSeitLetzterÄnderung < WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
            then
               return False;
              
            elsif
              JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageKriegErklären) = True
            then
               DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                            RasseZweiExtern   => GegnerischeRasseExtern,
                                            NeuerStatusExtern => DiplomatieDatentypen.Krieg_Enum);
               return True;
                  
            else
               return False;
            end if;
                  
         when DiplomatieDatentypen.Krieg_Enum =>
            return True;

         when others =>
            return False;
      end case;
      
   end GegnerAngreifen;
   
   
   
   procedure VergangeneZeitÄndern
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung
      is
         when ZahlenDatentypen.EigenesNatural'Last =>
            null;
                     
         when others =>
            SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung := SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung + 1;
      end case;
      
   end VergangeneZeitÄndern;

end DiplomatischerZustandLogik;
