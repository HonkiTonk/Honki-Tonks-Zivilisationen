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
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return EinheitenDatentypen.Einheitart_Enum;
   -- with
   --   Pre => (
   --             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
   --         );
   
   function PreisGeld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Produktionskosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return ProduktionDatentypen.Produktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function PermanenteKosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Vorhanden_Enum)
      return ProduktionDatentypen.Stadtproduktion
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Anforderungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return ForschungenDatentypen.ForschungIDUnmöglich
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function GebäudeBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis;
      GebäudeExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Passierbarkeit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
      
   function MaximaleLebenspunkte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return KampfDatentypen.LebenspunkteVorhanden
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function MaximaleBewegungspunkte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return EinheitenDatentypen.BewegungspunkteVorhanden
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function VerbesserungZu
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return EinheitenDatentypen.EinheitenIDBasis
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Beförderungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return KampfDatentypen.ErfahrungspunkteBasis
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function MaximalerRang
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return KampfDatentypen.Rang
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Reichweite
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return KampfDatentypen.ReichweiteBasis
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Angriff
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return KampfDatentypen.KampfwerteEinheiten
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Verteidigung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return KampfDatentypen.KampfwerteEinheiten
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function KannTransportieren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return EinheitenDatentypen.Transport_Enum;
   -- Kann wegen LadenEinheitenLogik nicht verwendet werden.
   -- with
   --   Pre => (
   --             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
   --          );
   
   function KannTransportiertWerden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return EinheitenDatentypen.Transport_Enum;
   -- Kann wegen LadenEinheitenLogik nicht verwendet werden.
   -- with
   --   Pre => (
   --             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
   --          );
   
   function Transportkapazität
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis)
      return EinheitenDatentypen.TransportplätzeBasis
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Zusatzeffekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis;
      EffektExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
     
   function Effektreichweite
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDBasis;
      EffektExtern : in KartenextraDatentypen.Effekt_Vorhanden_Enum)
      return KartenRecords.EffektbereichRecord
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end LeseEinheitenDatenbank;
