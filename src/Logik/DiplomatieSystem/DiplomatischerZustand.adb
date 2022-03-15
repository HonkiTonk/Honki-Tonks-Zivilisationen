pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SonstigesKonstanten;

with Auswahl;

package body DiplomatischerZustand is

   procedure DiplomatischenStatusÄndern
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Enum)
   is begin
      
      GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand := NeuerStatusExtern;
      GlobaleVariablen.Diplomatie (RasseZweiExtern, RasseEinsExtern).AktuellerZustand := NeuerStatusExtern;
      
      GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung := 0;
      GlobaleVariablen.Diplomatie (RasseZweiExtern, RasseEinsExtern).ZeitSeitLetzterÄnderung := 0;
            
      case
        NeuerStatusExtern
      is
         when SystemDatentypen.Krieg =>
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
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return SystemDatentypen.Status_Untereinander_Enum
   is begin
      
      return GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuellerZustand;
      
   end DiplomatischenStatusPrüfen;
   
   
   
   function DiplomatischerStatusLetzteÄnderung
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Natural
   is begin
      
      return GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).ZeitSeitLetzterÄnderung;
      
   end DiplomatischerStatusLetzteÄnderung;
   
   
   
   function AktuelleSympathie
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return EinheitStadtDatentypen.ProduktionFeld
   is begin
      
      return GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung;
      
   end AktuelleSympathie;
   
   
   
   procedure SympathieÄndern
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      FremdeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      ÄnderungExtern : in EinheitStadtDatentypen.ProduktionFeld)
   is begin
      
      if
        GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung + ÄnderungExtern > SympathieGrenzen (DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                                                                                                                                         FremdeRasseExtern => FremdeRasseExtern))
      then
         GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung := SympathieGrenzen (DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                                                                                                                                         FremdeRasseExtern => FremdeRasseExtern));
           
      elsif
        GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung + ÄnderungExtern < EinheitStadtDatentypen.ProduktionFeld'First
      then
         GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung := EinheitStadtDatentypen.ProduktionFeld'First;
                                                                                                                            
      else
         GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung := GlobaleVariablen.Diplomatie (EigeneRasseExtern, FremdeRasseExtern).AktuelleSympathieBewertung + ÄnderungExtern;
      end if;
      
   end SympathieÄndern;



   function GegnerAngreifen
     (EigeneRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      GegnerischeRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      case
        DiplomatischenStatusPrüfen (EigeneRasseExtern => EigeneRasseExtern,
                                     FremdeRasseExtern => GegnerischeRasseExtern)
      is
         when SystemDatentypen.Neutral =>
            if
              GlobaleVariablen.Diplomatie (EigeneRasseExtern, GegnerischeRasseExtern).ZeitSeitLetzterÄnderung < SonstigesKonstanten.DiplomatischerStatusÄnderungszeit
            then
               return False;
              
            elsif
              Auswahl.AuswahlJaNein (FrageZeileExtern => 11) = SystemKonstanten.JaKonstante
            then
               DiplomatischenStatusÄndern (RasseEinsExtern   => EigeneRasseExtern,
                                            RasseZweiExtern   => GegnerischeRasseExtern,
                                            NeuerStatusExtern => SystemDatentypen.Krieg);
               return True;
                  
            else
               return False;
            end if;
                  
         when SystemDatentypen.Krieg =>
            return True;

         when others =>
            return False;
      end case;
      
   end GegnerAngreifen;
   
   
   
   procedure VergangeneZeitÄndern
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung
      is
         when Natural'Last =>
            null;
                     
         when others =>
            GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung
              := GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung + 1;
      end case;
      
   end VergangeneZeitÄndern;

end DiplomatischerZustand;
