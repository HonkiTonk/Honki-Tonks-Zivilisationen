with KartenDatentypen;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitenmodifizierungLogik;
with ForschungstestsLogik;
with EinheitentransporterLogik;

package body EinheitVerbessernLogik is

   function VerbesserungEinheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type KartenDatentypen.Kartenfeld;
   begin
      
      NeueEinheitenID := EinheitVerbesserbar (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        NeueEinheitenID = EinheitenKonstanten.LeerID
      then
         return False;
           
      elsif
        False = LeseWeltkarte.BelegterGrund (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                             KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      then
         return False;
         
      else
         null;
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     BewegungspunkteExtern      => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern        => False);
      
            EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                 VorzeichenWechselExtern    => -1);
      
            SchreibeEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                        IDExtern                   => NeueEinheitenID);
      
            EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                 VorzeichenWechselExtern    => 1);
                                    
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungEinheit;
   
   
   
   function EinheitVerbesserbar
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
   
      NeueEinheitenID := LeseEinheitenDatenbank.VerbesserungZu (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      if
        NeueEinheitenID = EinheitenKonstanten.LeerID
      then
         return EinheitenKonstanten.LeerID;
         
      elsif
        False = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                           TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                      IDExtern      => NeueEinheitenID))
      then
         return EinheitenKonstanten.LeerID;
         
      elsif
        False = WeiterhinTransportierbar (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                          NeueIDExtern               => NeueEinheitenID)
      then
         return EinheitenKonstanten.LeerID;
         
      elsif
        False = LaderaumAusreichend (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                     NeueIDExtern               => NeueEinheitenID)
      then
         return EinheitenKonstanten.LeerID;
         
      else
         return NeueEinheitenID;
      end if;
            
   end EinheitVerbesserbar;
   
   
   
   function WeiterhinTransportierbar
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueIDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
   begin
            
      Transporternummer := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Transporternummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return True;
            
         when others =>
            TransporterID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Transporternummer));
      end case;
      
      -- Wenn die Nummer ungleich Null ist, dann sollte die ID auch immer ungleich Null sein, kann die erste Prüfung dann nicht raus? äöü
      -- Dann könnte ich auch einfach return TransporterGroßGenug machen. äöü
      if
        TransporterID = EinheitenKonstanten.LeerID
      then
         null;
         
      elsif
        False = EinheitentransporterLogik.TransporterGroßGenug (LadungExtern      => NeueIDExtern,
                                                                 TransporterExtern => TransporterID,
                                                                 SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
      then
         return False;
         
      else
         null;
      end if;
      
      return True;
      
   end WeiterhinTransportierbar;
   
   
   
   function LaderaumAusreichend
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueIDExtern : in EinheitenDatentypen.EinheitenIDMitNullWert)
      return Boolean
   is
      use type EinheitenDatentypen.Transportplätze;
   begin
      
      -- Hier muss die aktuelle ID geprüft werden um die aktuelle Transportkapazität zu bekommen, auf keinen Fall die Neue einsetzen!
      AktuelleTransporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                   IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      NeueTransporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                               IDExtern      => NeueIDExtern);
      
      if
        NeueTransporterkapazität >= AktuelleTransporterkapazität
        or
          NeueTransporterkapazität >= EinheitentransporterLogik.BelegtePlätze (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                 TransportkapazitätExtern  => NeueTransporterkapazität)
      then
         return True;
            
      else
         return False;
      end if;
      
   end LaderaumAusreichend;

end EinheitVerbessernLogik;
