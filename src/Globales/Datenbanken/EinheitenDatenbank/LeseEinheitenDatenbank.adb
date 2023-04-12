with EinheitenKonstanten;
with StadtKonstanten;
with EinheitenDatenbank;
with ProduktionKonstanten;
with ForschungKonstanten;
with KampfKonstanten;
with KartenRecordKonstanten;

package body LeseEinheitenDatenbank is

   function Einheitenart
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.Einheitart_Enum
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
      
      if
        IDExtern = EinheitenKonstanten.LeerID
        or
          LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Leer_Spieler_Enum
      then
         return EinheitenKonstanten.LeerEinheitArt;
              
      else
         return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Einheitenart;
      end if;
      
   end Einheitenart;
   
   
   
   function PreisGeld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return ProduktionDatentypen.Produktion
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).PreisGeld;
      end case;
      
   end PreisGeld;
   
   
   
   function Produktionskosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return ProduktionDatentypen.Produktion
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Produktionskosten;
      end case;
      
   end Produktionskosten;
   
   
   
   function PermanenteKosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            null;
      end case;
      
      if
        EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).PermanenteKosten (WelcheKostenExtern) < StadtKonstanten.LeerPermanenteKosten
      then
         return EinheitenKonstanten.LeerPermanenteKosten;
      
      else
         return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      end if;
      
   end PermanenteKosten;
   
   
   
   function Anforderungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return ForschungKonstanten.ForschungUnmöglich;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Anforderungen;
      end case;
      
   end Anforderungen;
   
   
   
   function GebäudeBenötigt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      GebäudeExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).NotwendigeGebäude (GebäudeExtern);
      end case;
      
   end GebäudeBenötigt;
   
   

   function Passierbarkeit
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Passierbarkeit (WelcheUmgebungExtern);
      end case;
      
   end Passierbarkeit;
   
   
         
   function MaximaleLebenspunkte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.VorhandeneLebenspunkte
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenDatentypen.VorhandeneLebenspunkte'First;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).MaximaleLebenspunkte;
      end case;
      
   end MaximaleLebenspunkte;
   
   
   
   function MaximaleBewegungspunkte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerBewegungspunkte;
            
         when others =>
            null;
      end case;
      
      if
        EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).MaximaleBewegungspunkte < EinheitenKonstanten.MinimalerBewegungspunkt
      then
         return EinheitenKonstanten.MinimalerBewegungspunkt;
         
      else
         return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).MaximaleBewegungspunkte;
      end if;
        
      
   end MaximaleBewegungspunkte;
   
   
   
   function VerbesserungZu
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerID;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).VerbesserungZu;
      end case;
      
   end VerbesserungZu;
   
   
   
   function Beförderungsgrenze
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.Erfahrungspunkte
   is begin
      
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return KampfKonstanten.LeerErfahrungspunkte;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Beförderungsgrenze;
      end case;
      
   end Beförderungsgrenze;
   
   
   
   function MaximalerRang
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.Rang
   is begin
                           
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return KampfKonstanten.LeerRang;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).MaximalerRang;
      end case;
      
   end MaximalerRang;
   
   
   
   function Reichweite
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.Reichweite
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return KampfKonstanten.LeerReichweite;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Reichweite;
      end case;
      
   end Reichweite;
   
   
   
   function Angriff
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.KampfwerteEinheiten
   is begin
      
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerAngriff;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Angriff;
      end case;
      
   end Angriff;
   
   
   
   function Verteidigung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.KampfwerteEinheiten
   is begin
      
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerVerteidigung;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Verteidigung;
      end case;
      
   end Verteidigung;
   
   
   
   -- Es muss darauf geachtet werden dass KannTransportieren immer kleiner ist als KannTransportiertWerden.
   -- Deswegen hier entsprechende Zusatzprüfungen einbauen?
   -- Nö, wenn hier jemand dran herumbasteln will und dabei Mist rauskommt ist das ja nicht mein Problem.
   function KannTransportieren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.Transport_Enum
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenDatentypen.Kein_Transport_Enum;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).KannTransportieren;
      end case;
      
   end KannTransportieren;
   
   
   
   function KannTransportiertWerden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.Transport_Enum
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenDatentypen.Kein_Transport_Enum;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).KannTransportiertWerden;
      end case;
      
   end KannTransportiertWerden;
   
   
   
   function Transportkapazität
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.Transportplätze
   is
      use type EinheitenDatentypen.Transport_Enum;
      use type EinheitenDatentypen.Transportplätze;
   begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerTransportkapazität;
            
         when others =>
            null;
      end case;
      
      if
        EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).KannTransportieren = EinheitenKonstanten.LeerKannTransportiertWerden
        or
          EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Transportkapazität = EinheitenKonstanten.LeerTransportkapazität
      then
         return EinheitenKonstanten.LeerTransportkapazität;
         
      else
         return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Transportkapazität;
      end if;
      
   end Transportkapazität;
   
   
   
   function Zusatzeffekt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      EffektExtern : in KartengrundDatentypen.Effekt_Vorhanden_Enum)
      return Boolean
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Zusatzeffekt (EffektExtern);
      end case;
            
   end Zusatzeffekt;
   
   
   
   function Effektreichweite
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      EffektExtern : in KartengrundDatentypen.Effekt_Vorhanden_Enum)
      return KartenRecords.EffektbereichRecord
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return KartenRecordKonstanten.LeerEffektbereich;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (SpeziesExtern, IDExtern).Effektreichweite (EffektExtern);
      end case;
      
   end Effektreichweite;

end LeseEinheitenDatenbank;
