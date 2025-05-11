with SpeziesDatentypen;
with EinheitenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with KampfDatentypen;
with KartenRecords;
with StadtDatentypen;
with KartenextraDatentypen;

with LeseSpeziesbelegung;

package LeseEinheitenDatenbank is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Einheitenart
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.Einheitart_Enum;
   -- with
   --   Pre => (
   --             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
   --         );
   
   function PreisGeld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Produktionskosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function PermanenteKosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Vorhanden_Enum)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Anforderungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return ForschungenDatentypen.ForschungIDUnmöglich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function GebäudeBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Passierbarkeit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function MaximaleLebenspunkte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KampfDatentypen.LebenspunkteVorhanden
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function MaximaleBewegungspunkte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.BewegungspunkteVorhanden
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function VerbesserungZu
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.EinheitenID
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Beförderungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KampfDatentypen.Erfahrungspunkte
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function MaximalerRang
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KampfDatentypen.Rang
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Reichweite
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KampfDatentypen.Reichweite
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Angriff
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KampfDatentypen.KampfwerteEinheiten
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Verteidigung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KampfDatentypen.KampfwerteEinheiten
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function KannTransportieren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.Transport_Enum;
   -- Kann wegen LadenEinheitenLogik nicht verwendet werden.
   -- with
   --   Pre => (
   --             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
   --          );
   
   function KannTransportiertWerden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.Transport_Enum;
   -- Kann wegen LadenEinheitenLogik nicht verwendet werden.
   -- with
   --   Pre => (
   --             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
   --          );
   
   function Transportkapazität
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.Transportplätze
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Zusatzeffekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      EffektExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
     
   function Effektreichweite
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      EffektExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return KartenRecords.EffektbereichRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseEinheitenDatenbank;
