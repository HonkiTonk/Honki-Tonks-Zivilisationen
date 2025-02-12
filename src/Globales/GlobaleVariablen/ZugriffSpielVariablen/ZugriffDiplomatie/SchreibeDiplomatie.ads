private with GanzzahltestsHTSEB;

with SpeziesDatentypen;
with DiplomatieDatentypen;
with ZahlenDatentypen;
with SpielRecords;

with LeseSpeziesbelegung;

package SchreibeDiplomatie is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type SpeziesDatentypen.Spezies_Enum;

   procedure AktuellerZustand
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ZustandExtern : in DiplomatieDatentypen.Status_Untereinander_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   pragma Inline (AktuellerZustand);
   
   procedure AktuelleSympathie
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SympathieExtern : in DiplomatieDatentypen.Meinung;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   
   procedure ZeitSeitÄnderung
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ÄnderungExtern : in ZahlenDatentypen.EigenesNatural;
      RechnenSetzenExtern : in Boolean)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesEinsExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesZweiExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
   procedure GanzerEintrag
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      EintragExtern : in SpielRecords.DiplomatieRecord)
     with
       Pre => (
                 SpeziesEinsExtern /= SpeziesZweiExtern
              );
   pragma Inline (GanzerEintrag);
   
private
   
   function EigeneZahlPrüfen is new GanzzahltestsHTSEB.Strichrechnung (GanzeZahl => ZahlenDatentypen.EigenesNatural);
   
   function MeinungPrüfen is new GanzzahltestsHTSEB.Strichrechnung (GanzeZahl => DiplomatieDatentypen.Meinung);

end SchreibeDiplomatie;
