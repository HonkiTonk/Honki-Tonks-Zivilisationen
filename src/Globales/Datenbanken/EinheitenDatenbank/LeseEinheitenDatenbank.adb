with EinheitenKonstanten;
with StadtKonstanten;

with EinheitenDatenbank;

package body LeseEinheitenDatenbank is

   function Einheitenart
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.Einheitart_Enum
   is begin
      
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerEinheitArt;
              
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Einheitenart;
      end case;
            
   end Einheitenart;
   
   
   
   function PreisGeld
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return ProduktionDatentypen.Produktion
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeld;
   
   
   
   function Produktionskosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return ProduktionDatentypen.Produktion
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Produktionskosten;
      
   end Produktionskosten;
   
   
   
   function PermanenteKosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      WelcheKostenExtern : in ProduktionDatentypen.Permanente_Kosten_Verwendet_Enum)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      if
        EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern) < StadtKonstanten.LeerPermanenteKosten
      then
         return EinheitenKonstanten.LeerPermanenteKosten;
      
      else
         return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      end if;
      
   end PermanenteKosten;
   
   
   
   function Anforderungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Anforderungen;
      
   end Anforderungen;
   
   

   function Passierbarkeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      WelcheUmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum)
      return Boolean
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Passierbarkeit (WelcheUmgebungExtern);
      
   end Passierbarkeit;
   
   
         
   function MaximaleLebenspunkte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.VorhandeneLebenspunkte
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleLebenspunkte;
      
   end MaximaleLebenspunkte;
   
   
   
   function MaximaleBewegungspunkte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.VorhandeneBewegungspunkte
   is
      use type EinheitenDatentypen.BewegungFloat;
   begin
      
      if
        EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleBewegungspunkte < 1.00
      then
         return 1.00;
         
      else
         return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleBewegungspunkte;
      end if;
        
      
   end MaximaleBewegungspunkte;
   
   
   
   function VerbesserungZu
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).VerbesserungZu;
      
   end VerbesserungZu;
   
   
   
   function Beförderungsgrenze
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.Erfahrungspunkte
   is begin
      
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return KampfDatentypen.Erfahrungspunkte'First;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Beförderungsgrenze;
      end case;
      
   end Beförderungsgrenze;
   
   
   
   function MaximalerRang
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.Rang
   is begin
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return KampfDatentypen.Rang'First;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximalerRang;
      end case;
      
   end MaximalerRang;
   
   
   
   function Reichweite
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KampfDatentypen.Reichweite
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Reichweite;
      
   end Reichweite;
   
   
   
   function Angriff
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.KampfwerteEinheiten
   is begin
      
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerAngriff;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Angriff;
      end case;
      
   end Angriff;
   
   
   
   function Verteidigung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.KampfwerteEinheiten
   is begin
      
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerVerteidigung;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Verteidigung;
      end case;
      
   end Verteidigung;
   
   
   
   -- Es muss darauf geachtet werden dass KannTransportieren immer kleiner ist als KannTransportiertWerden.
   -- Deswegen hier entsprechende Zusatzprüfungen einbauen?
   -- Nö, wenn hier jemand dran herumbasteln will und dabei Mist rauskommt ist das ja nicht mein Problem.
   function KannTransportieren
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.Transport_Enum
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).KannTransportieren;
      
   end KannTransportieren;
   
   
   
   function KannTransportiertWerden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.Transport_Enum
   is begin
      
      return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).KannTransportiertWerden;
      
   end KannTransportiertWerden;
   
   
   
   function Transportkapazität
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.Transportplätze
   is
      use type EinheitenDatentypen.Transport_Enum;
      use type EinheitenDatentypen.Transportplätze;
   begin
      
      if
        EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).KannTransportieren = EinheitenKonstanten.LeerKannTransportiertWerden
        or
          EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Transportkapazität = EinheitenKonstanten.LeerTransportkapazität
      then
         return EinheitenKonstanten.LeerTransportkapazität;
         
      else
         return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Transportkapazität;
      end if;
      
   end Transportkapazität;

end LeseEinheitenDatenbank;
