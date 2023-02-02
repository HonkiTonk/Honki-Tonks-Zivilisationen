with WichtigesKonstanten;
with TextnummernKonstanten;

with LeseDiplomatie;

with DiplomatischerZustandLogik;
with MeldungFestlegenLogik;

package body DiplomatischerZustandAenderbarLogik is

   procedure StatusÄnderbarkeitPrüfen
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum;
      ZeitbegrenzungBerücksichtigenExtern : in Boolean)
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      if
        NeuerStatusExtern = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesEinsExtern,
                                                             SpeziesZweiExtern => SpeziesZweiExtern)
      then
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungStatus);
         return;
         
      else
         AktuellerStatus := LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesEinsExtern,
                                                             SpeziesZweiExtern => SpeziesZweiExtern);
         
         ZeitSeitÄnderung := LeseDiplomatie.ZeitSeitÄnderung (SpeziesEinsExtern => SpeziesEinsExtern,
                                                                SpeziesZweiExtern => SpeziesZweiExtern);
         
         -- Die Sympathiewerte einer Spezies zu einer Anderen müssen nur Zwei zu Eins berücksichtigt werden, da Eins ja was von Zwei will.
         SympathieZweiZuEins := LeseDiplomatie.AktuelleSympathie (SpeziesEinsExtern => SpeziesZweiExtern,
                                                                  SpeziesZweiExtern => SpeziesEinsExtern);
      end if;
      
      case
        NeuerStatusExtern
      is
         when DiplomatieDatentypen.Neutral_Enum =>
            ÄnderungMöglich := NeutralMöglich (AktuellerStatusExtern => AktuellerStatus);
                        
         when DiplomatieDatentypen.Nichtangriffspakt_Enum =>
            ÄnderungMöglich := NichtangriffspaktMöglich (AktuellerStatusExtern => AktuellerStatus);
                        
         when DiplomatieDatentypen.Krieg_Enum =>
            ÄnderungMöglich := KriegMöglich (AktuellerStatusExtern               => AktuellerStatus,
                                                ZeitbegrenzungBerücksichtigenExtern => ZeitbegrenzungBerücksichtigenExtern);
      end case;
      
      case
        ÄnderungMöglich
      is
         when True =>
            DiplomatischerZustandLogik.DiplomatischenStatusÄndern (SpeziesEinsExtern => SpeziesEinsExtern,
                                                                    SpeziesZweiExtern => SpeziesZweiExtern,
                                                                    NeuerStatusExtern => NeuerStatusExtern);
            
         when False =>
            null;
      end case;
      
   end StatusÄnderbarkeitPrüfen;
   
   
   
   function NeutralMöglich
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type DiplomatieDatentypen.Meinung;
   begin
      
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
            SympathieZweiZuEins >= DiplomatischerZustandLogik.SympathieGrenzen (AktuellerStatusExtern) - 20
      then
         return True;
         
      else
         return False;
      end if;
      
   end NeutralMöglich;
   
   
   
   function NichtangriffspaktMöglich
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type DiplomatieDatentypen.Meinung;
   begin
      
      if
        AktuellerStatusExtern = DiplomatieDatentypen.Krieg_Enum
      then
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungImKrieg);
         return False;
         
      elsif
        AktuellerStatusExtern = DiplomatieDatentypen.Neutral_Enum
        and
          SympathieZweiZuEins >= DiplomatischerZustandLogik.SympathieGrenzen (AktuellerStatusExtern) - 10
      then
         return True;
         
      else
         return False;
      end if;
      
   end NichtangriffspaktMöglich;
   
   
   
   -- ZeitbegrenzungBerücksichtigenExtern wird aktuelle verwendet um die ZeitSeitÄnderung UND den Nichtangriffspakt zu ignorieren.
   -- Bei eventuell kommenden Erweiterungen am Diplomatiesystem das entsprechend berücksichtigen.
   function KriegMöglich
     (AktuellerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Bekannt_Enum;
      ZeitbegrenzungBerücksichtigenExtern : in Boolean)
      return Boolean
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      if
        AktuellerStatusExtern = DiplomatieDatentypen.Nichtangriffspakt_Enum
        and
          ZeitbegrenzungBerücksichtigenExtern
      then
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungNichtangriffspakt);
         return False;
         
      elsif
        AktuellerStatusExtern = DiplomatieDatentypen.Neutral_Enum
        and
          ZeitSeitÄnderung >= WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      elsif
        AktuellerStatusExtern /= DiplomatieDatentypen.Krieg_Enum
        and
          ZeitbegrenzungBerücksichtigenExtern = False
      then
         return True;
                 
      else
         return False;
      end if;
      
   end KriegMöglich;

end DiplomatischerZustandAenderbarLogik;
