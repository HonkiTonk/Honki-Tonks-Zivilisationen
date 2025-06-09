with MeldungssystemHTSEB;

with KartenKonstanten;
with SystemDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with TransporterSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;
with BewegungsberechnungEinheitenLogik;
with TransporterBeladenEntladenLogik;

-- Das vielleicht mal mit TransporterBeladenEntladenLogik/TransporterLadungsverschiebungLogik zusammenführen? äöü
package body EinheitentransporterLogik is
   
   -- Eventuell für Ladung und Transporter die Spezies übergeben und dann eine Sicherheitsprüfung einbauen ob es die gleiche Spezies ist und wenn nicht einen Fehler ausgeben? äöü
   function TransporterGroßGenug
     (LadungExtern : in EinheitenDatentypen.EinheitenID;
      TransporterExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is
      use type EinheitenDatentypen.Transport_Enum;
   begin
      
      if
        EinheitenKonstanten.LeerKannTransportiertWerden = LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => SpeziesExtern,
                                                                                                          IDExtern      => LadungExtern)
        or
          LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => SpeziesExtern,
                                                     IDExtern      => TransporterExtern)
        < LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => SpeziesExtern,
                                                          IDExtern      => LadungExtern)
      then
         return False;
         
      else
         return True;
      end if;
      
   end TransporterGroßGenug;
   
   
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      TransporterID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern);
      
      case
        TransporterID
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            LadungID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => LadungExtern);
      end case;
        
      case
        TransporterGroßGenug (LadungExtern      => LadungID,
                               TransporterExtern => TransporterID,
                               SpeziesExtern     => LadungExtern.Spezies)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        TransporterSuchenLogik.FreierPlatz (TransporterExtern => TransporterExtern)
      is
         when EinheitenKonstanten.LeerTransportkapazität =>
            return False;

         when others =>
            return True;
      end case;
      
   end KannTransportiertWerden;
   
   
   
   procedure TransporterEntladen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                           IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern));
      TransporterKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => TransporterExtern);
      
      TransporterAusladenSchleife:
      for TransporterAusladenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop

         AktuelleLadung := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                              PlatzExtern                => TransporterAusladenSchleifenwert);
         
         case
           AktuelleLadung
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
               
            when others =>
               TransporterUmgebung (TranspoterKoordinatenExtern => TransporterKoordinaten,
                                    LadungExtern                => (TransporterExtern.Spezies, AktuelleLadung));
         end case;
               
      end loop TransporterAusladenSchleife;
      
      TransporterBeladenEntladenLogik.LadungSortieren (TransporterExtern => TransporterExtern);
      
   end TransporterEntladen;
   
   
   
   procedure TransporterUmgebung
     (TranspoterKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => TranspoterKoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              SenkrechteSchleifenwert = 0
              and
                WaagerechteSchleifenwert = 0
            then
               null;
               
            elsif
              False = Entladung (KoordinatenExtern => KartenWert,
                                 LadungExtern      => LadungExtern)
            then
               null;
               
            else
               BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => LadungExtern,
                                                                      NeueKoordinatenExtern      => KartenWert,
                                                                      EinheitentauschExtern      => False);
               return;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end TransporterUmgebung;
   
   
   
   function Entladung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      EinheitVorhanden := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                  TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        EinheitVorhanden.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            return False;
      end case;
      
      if
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => LadungExtern,
                                                                          NeueKoordinatenExtern      => KoordinatenExtern)
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => LadungExtern) < BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern      => KoordinatenExtern,
                                                                                                                                          EinheitSpeziesNummerExtern => LadungExtern)
      then
         return False;
         
      else
         return True;
      end if;
      
   end Entladung;
   
   
   
   function BelegtePlätze
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransportkapazitätExtern : in EinheitenDatentypen.Transportplätze)
      return EinheitenDatentypen.Transportplätze
   is
      use type EinheitenDatentypen.Transportplätze;
   begin
      
      AktuelleLadungsmenge := EinheitenKonstanten.LeerTransportkapazität;
      
      BelegtePlätzeSchleife:
      for BelegtePlätzeSchleifenwert in EinheitenRecords.TransporterArray'First .. TransportkapazitätExtern loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              PlatzExtern                => BelegtePlätzeSchleifenwert)
         is
            when EinheitenKonstanten.LeerNummer =>
               null;
               
            when others =>
               AktuelleLadungsmenge := AktuelleLadungsmenge + 1;
         end case;
         
      end loop BelegtePlätzeSchleife;
      
      return AktuelleLadungsmenge;
      
   end BelegtePlätze;
   
   
   
   procedure LadungsnummerAnpassen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungsnummerAltExtern : in EinheitenDatentypen.EinheitenbereichVorhanden;
      LadungsnummerNeuExtern : in EinheitenDatentypen.Einheitenbereich)
   is begin
      
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                                                                        IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern)) loop
         
         if
           LadungsnummerAltExtern = LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                                       PlatzExtern                => LadungSchleifenwert)
         then
            SchreibeEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                   LadungExtern               => LadungsnummerNeuExtern,
                                                   LadungsplatzExtern         => LadungSchleifenwert);
            return;
               
         else
            null;
         end if;
         
      end loop LadungSchleife;
      
      MeldungssystemHTSEB.Logik (MeldungExtern => "EinheitentransporterLogik.LadungsnummerAnpassen: Transportierte Einheit wird nicht transportiert");
      
   end LadungsnummerAnpassen;
   
   
   
   procedure LadungAnpassen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                                                                        IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern)) loop
         
         AktuelleLadung := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                              PlatzExtern                => LadungSchleifenwert);
         
         case
           AktuelleLadung
         is
            when EinheitenKonstanten.LeerNummer =>
               null;
               
            when others =>
               SchreibeEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (TransporterExtern.Spezies, AktuelleLadung),
                                                          TransporterExtern          => TransporterExtern.Nummer);
         end case;
         
      end loop LadungSchleife;
      
   end LadungAnpassen;

end EinheitentransporterLogik;
