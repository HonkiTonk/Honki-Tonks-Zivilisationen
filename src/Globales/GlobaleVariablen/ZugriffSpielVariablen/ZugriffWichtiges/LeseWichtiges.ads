with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with SpielRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package LeseWichtiges is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type StadtDatentypen.Städtebereich;
   use type EinheitenDatentypen.Einheitenbereich;

   function Geldmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Integer
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Geldmenge);
   
   function GeldRundengewinn
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GeldRundengewinn);

   function GesamteForschungsrate
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GesamteForschungsrate);
   
   function Forschungsmenge
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Forschungsmenge);
   
   function VerbleibendeForschungszeit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ProduktionDatentypen.Lagermenge
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (VerbleibendeForschungszeit);
   
   function Forschungsprojekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return ForschungenDatentypen.ForschungID
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Forschungsprojekt);

   function Erforscht
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      WelcheTechnologieExtern : in ForschungenDatentypen.ForschungIDVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (Erforscht);
   
   function AnzahlStädte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return StadtDatentypen.Städtebereich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlStädte'Result <= LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern)
               );
   pragma Inline (AnzahlStädte);
   
   function AnzahlEinheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlEinheiten'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );
   pragma Inline (AnzahlEinheiten);
   
   function AnzahlArbeiter
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlArbeiter'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );
   pragma Inline (AnzahlArbeiter);
     
   function AnzahlKämpfer
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlKämpfer'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );
   pragma Inline (AnzahlKämpfer);
     
   function AnzahlSonstiges
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return EinheitenDatentypen.Einheitenbereich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
   
       Post => (
                  AnzahlSonstiges'Result <= LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern)
               );
   pragma Inline (AnzahlSonstiges);
   
   function GanzerEintrag
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return SpielRecords.WichtigesRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   pragma Inline (GanzerEintrag);

end LeseWichtiges;
