pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with WichtigesKonstanten;

with DiplomatischerZustand;

package body DiplomatischerZustandAenderbar is

   procedure StatusÄnderbarkeitPrüfen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
   is begin
      
      if
        NeuerStatusExtern = SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand
      then
         return;
         
      else
         AktuellerStatus := DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseEinsExtern,
                                                                               FremdeRasseExtern => RasseZweiExtern);
         
         ZeitSeitÄnderung := DiplomatischerZustand.DiplomatischerStatusLetzteÄnderung (EigeneRasseExtern => RasseEinsExtern,
                                                                                         FremdeRasseExtern => RasseZweiExtern);
         
         -- Die Sympathiewerte einer Rasse zu einer Anderen müssen nur Zwei zu Eins berücksichtigt werden, da Eins ja was von Zwei will.
         SympathieZweiZuEins := DiplomatischerZustand.AktuelleSympathie (EigeneRasseExtern => RasseZweiExtern,
                                                                         FremdeRasseExtern => RasseEinsExtern);
      end if;
      
      case
        NeuerStatusExtern
      is
         when DiplomatieDatentypen.Neutral_Enum =>
            ÄnderungMöglich := NeutralMöglich;
                        
         when DiplomatieDatentypen.Nichtangriffspakt_Enum =>
            ÄnderungMöglich := NichtangriffspaktMöglich;
                        
         when DiplomatieDatentypen.Krieg_Enum =>
            ÄnderungMöglich := KriegMöglich;
      end case;
      
      case
        ÄnderungMöglich
      is
         when True =>
            DiplomatischerZustand.DiplomatischenStatusÄndern (RasseEinsExtern   => RasseEinsExtern,
                                                               RasseZweiExtern   => RasseZweiExtern,
                                                               NeuerStatusExtern => NeuerStatusExtern);
            
         when False =>
            null;
      end case;
      
   end StatusÄnderbarkeitPrüfen;
   
   
   
   function NeutralMöglich
     return Boolean
   is begin
      
      if
        AktuellerStatus = DiplomatieDatentypen.Nichtangriffspakt_Enum
        and
          ZeitSeitÄnderung >= WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      elsif
        AktuellerStatus = DiplomatieDatentypen.Krieg_Enum
        and
          ZeitSeitÄnderung >= 10
          and
            SympathieZweiZuEins >= DiplomatischerZustand.SympathieGrenzen (AktuellerStatus) - 20
      then
         return True;
         
      else
         return False;
      end if;
      
   end NeutralMöglich;
   
   
   
   function NichtangriffspaktMöglich
     return Boolean
   is begin
      
      if
        AktuellerStatus = DiplomatieDatentypen.Krieg_Enum
      then
         return False;
         
      elsif
        AktuellerStatus = DiplomatieDatentypen.Neutral_Enum
        and
          SympathieZweiZuEins >= DiplomatischerZustand.SympathieGrenzen (AktuellerStatus) - 10
      then
         return True;
         
      else
         return False;
      end if;
      
   end NichtangriffspaktMöglich;
   
   
   
   function KriegMöglich
     return Boolean
   is begin
      
      if        
        AktuellerStatus = DiplomatieDatentypen.Nichtangriffspakt_Enum
      then
         return False;
         
      elsif
        AktuellerStatus = DiplomatieDatentypen.Neutral_Enum
        and
          ZeitSeitÄnderung >= WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      else
         return False;
      end if;
      
   end KriegMöglich;

end DiplomatischerZustandAenderbar;
