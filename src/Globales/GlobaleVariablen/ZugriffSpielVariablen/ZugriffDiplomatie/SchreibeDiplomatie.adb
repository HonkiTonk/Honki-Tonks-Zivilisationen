with WichtigesRecordKonstanten;
with SpielVariablen;

package body SchreibeDiplomatie is

   procedure AktuellerZustand
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ZustandExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
   is begin
      
      SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).AktuellerZustand := ZustandExtern;
      
   end AktuellerZustand;
   
   
   
   procedure AktuelleSympathie
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SympathieExtern : in DiplomatieDatentypen.Meinung;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).AktuelleSympathieBewertung :=
              MeinungPrüfen (GrundwertExtern  => SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).AktuelleSympathieBewertung,
                             ZusatzwertExtern => SympathieExtern);
            
         when False =>
            SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).AktuelleSympathieBewertung := SympathieExtern;
      end case;
      
   end AktuelleSympathie;
   
   
   
   procedure ZeitSeitÄnderung
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ÄnderungExtern : in ZahlenDatentypen.EigenesNatural;
      RechnenSetzenExtern : in Boolean)
   is begin
      
      case
        RechnenSetzenExtern
      is
         when True =>
            SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).ZeitSeitLetzterÄnderung
              := EigeneZahlPrüfen (GrundwertExtern  => SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).ZeitSeitLetzterÄnderung,
                                   ZusatzwertExtern => ÄnderungExtern);
            
         when False =>
            SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern).ZeitSeitLetzterÄnderung := ÄnderungExtern;
      end case;
      
   end ZeitSeitÄnderung;
   
   
   
   procedure Standardeinstellungen
   is begin
            
      SpielVariablen.Diplomatie := (others => (others => WichtigesRecordKonstanten.StartDiplomatie));
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EintragExtern : in SpielRecords.DiplomatieRecord)
   is begin
      
      SpielVariablen.Diplomatie (SpeziesEinsExtern, SpeziesZweiExtern) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeDiplomatie;
