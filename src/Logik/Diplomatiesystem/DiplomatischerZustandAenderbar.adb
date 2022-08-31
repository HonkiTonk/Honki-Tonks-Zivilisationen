pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with WichtigesKonstanten;
with TextnummernKonstanten;

with DiplomatischerZustand;
with MeldungFestlegenLogik;

package body DiplomatischerZustandAenderbar is

   procedure StatusÄnderbarkeitPrüfen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
   is begin
      
      if
        NeuerStatusExtern = SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand
      then
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungStatus);
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
            ÄnderungMöglich := NeutralMöglich (AktuellerStatusExtern => AktuellerStatus);
                        
         when DiplomatieDatentypen.Nichtangriffspakt_Enum =>
            ÄnderungMöglich := NichtangriffspaktMöglich (AktuellerStatusExtern => AktuellerStatus);
                        
         when DiplomatieDatentypen.Krieg_Enum =>
            ÄnderungMöglich := KriegMöglich (AktuellerStatusExtern => AktuellerStatus);
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
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
   is begin
      
      if
        AktuellerStatusExtern = DiplomatieDatentypen.Nichtangriffspakt_Enum
        and
          ZeitSeitÄnderung >= WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      elsif
        AktuellerStatusExtern = DiplomatieDatentypen.Krieg_Enum
        and
          ZeitSeitÄnderung >= 10
          and
            SympathieZweiZuEins >= DiplomatischerZustand.SympathieGrenzen (AktuellerStatusExtern) - 20
      then
         return True;
         
      else
         return False;
      end if;
      
   end NeutralMöglich;
   
   
   
   function NichtangriffspaktMöglich
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
   is begin
      
      if
        AktuellerStatusExtern = DiplomatieDatentypen.Krieg_Enum
      then
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungImKrieg);
         return False;
         
      elsif
        AktuellerStatusExtern = DiplomatieDatentypen.Neutral_Enum
        and
          SympathieZweiZuEins >= DiplomatischerZustand.SympathieGrenzen (AktuellerStatusExtern) - 10
      then
         return True;
         
      else
         return False;
      end if;
      
   end NichtangriffspaktMöglich;
   
   
   
   function KriegMöglich
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
   is begin
      
      if        
        AktuellerStatusExtern = DiplomatieDatentypen.Nichtangriffspakt_Enum
      then
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungNichtangriffspakt);
         return False;
         
      elsif
        AktuellerStatusExtern = DiplomatieDatentypen.Neutral_Enum
        and
          ZeitSeitÄnderung >= WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      else
         return False;
      end if;
      
   end KriegMöglich;

end DiplomatischerZustandAenderbar;
