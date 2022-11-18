with EinheitenKonstanten;
with StadtKonstanten;
with EinheitenDatenbank;
with ProduktionKonstanten;
with ForschungKonstanten;
with KampfKonstanten;

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
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return ProduktionDatentypen.Produktion
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PreisGeld;
      end case;
      
   end PreisGeld;
   
   
   
   function Produktionskosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return ProduktionDatentypen.Produktion
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return ProduktionKonstanten.LeerProduktion;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Produktionskosten;
      end case;
      
   end Produktionskosten;
   
   
   
   function PermanenteKosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
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
        EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern) < StadtKonstanten.LeerPermanenteKosten
      then
         return EinheitenKonstanten.LeerPermanenteKosten;
      
      else
         return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).PermanenteKosten (WelcheKostenExtern);
      end if;
      
   end PermanenteKosten;
   
   
   
   function Anforderungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return ForschungKonstanten.ForschungUnmöglich;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Anforderungen;
      end case;
      
   end Anforderungen;
   
   

   function Passierbarkeit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
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
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Passierbarkeit (WelcheUmgebungExtern);
      end case;
      
   end Passierbarkeit;
   
   
         
   function MaximaleLebenspunkte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.VorhandeneLebenspunkte
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenDatentypen.VorhandeneLebenspunkte'First;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleLebenspunkte;
      end case;
      
   end MaximaleLebenspunkte;
   
   
   
   function MaximaleBewegungspunkte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
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
        EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleBewegungspunkte < EinheitenKonstanten.MinimalerBewegungspunkt
      then
         return EinheitenKonstanten.MinimalerBewegungspunkt;
         
      else
         return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximaleBewegungspunkte;
      end if;
        
      
   end MaximaleBewegungspunkte;
   
   
   
   function VerbesserungZu
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerID;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).VerbesserungZu;
      end case;
      
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
            return KampfKonstanten.LeerErfahrungspunkte;
            
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
            return KampfKonstanten.LeerRang;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).MaximalerRang;
      end case;
      
   end MaximalerRang;
   
   
   
   function Reichweite
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return KampfDatentypen.Reichweite
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
           return KampfKonstanten.LeerReichweite;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).Reichweite;
      end case;
      
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
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.Transport_Enum
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenDatentypen.Kein_Transport_Enum;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).KannTransportieren;
      end case;
      
   end KannTransportieren;
   
   
   
   function KannTransportiertWerden
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return EinheitenDatentypen.Transport_Enum
   is begin
            
      case
        IDExtern
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenDatentypen.Kein_Transport_Enum;
            
         when others =>
            return EinheitenDatenbank.Einheitenliste (RasseExtern, IDExtern).KannTransportiertWerden;
      end case;
      
   end KannTransportiertWerden;
   
   
   
   function Transportkapazität
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
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
