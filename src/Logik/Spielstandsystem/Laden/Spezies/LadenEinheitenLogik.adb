with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with SpielstandAllgemeinesLogik;

package body LadenEinheitenLogik is

   function Einheiten
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      EinheitenDatentypen.Einheitenbereich'Read (Stream (File => DateiLadenExtern),
                                                 VorhandeneEinheiten);
      
      case
        VorhandeneEinheiten
      is
         when 0 =>
            return True;
            
         when others =>
            Belegung := SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SpeziesExtern);
      end case;
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. VorhandeneEinheiten loop
         
         case
           Einheitenwerte (LadenPrüfenExtern => LadenPrüfenExtern,
                           SpeziesExtern     => SpeziesExtern,
                           BelegungExtern    => Belegung,
                           DateiLadenExtern  => DateiLadenExtern,
                           EinheitExtern     => EinheitSchleifenwert)
         is
            when False =>
               return False;
               
            when True =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenEinheitenLogik.Einheiten: Konnte nicht geladen werden: LadenPrüfenExtern =" & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Einheiten;
   
   
   
   function Einheitenwerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BelegungExtern : in SpeziesDatentypen.Spieler_Belegt_Enum;
      DateiLadenExtern : in File_Type;
      EinheitExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return Boolean
   is
      use type EinheitenDatentypen.Einheitenbereich;
      use type SpeziesDatentypen.Spieler_Enum;
   begin
      
      EinheitenDatentypen.EinheitenIDVorhanden'Read (Stream (File => DateiLadenExtern),
                                                     ID);
      
      KartenRecords.KartenfeldNaturalRecord'Read (Stream (File => DateiLadenExtern),
                                                  Koordinaten);
      
      StadtDatentypen.Städtebereich'Read (Stream (File => DateiLadenExtern),
                                           Heimatstadt);
      
      KampfDatentypen.LebenspunkteVorhanden'Read (Stream (File => DateiLadenExtern),
                                                  Lebenspunkte);
                  
      EinheitenDatentypen.BewegungspunkteVorhanden'Read (Stream (File => DateiLadenExtern),
                                                         Bewegungspunkte);
                  
      KampfDatentypen.Erfahrungspunkte'Read (Stream (File => DateiLadenExtern),
                                             Erfahrungspunkte);
      
      KampfDatentypen.Rang'Read (Stream (File => DateiLadenExtern),
                                 Rang);
         
      EinheitenRecords.ArbeitRecord'Read (Stream (File => DateiLadenExtern),
                                          Beschäftigung);
                                                          
      EinheitenRecords.ArbeitRecord'Read (Stream (File => DateiLadenExtern),
                                          BeschäftigungNachfolger);
                                          
      -- Das hier wird auch für die Festlegung der menschlichen Bewegung verwendet, muss also Belegungsunabhängig gespeichert werden.
      KartenRecords.KartenfeldNaturalRecord'Read (Stream (File => DateiLadenExtern),
                                                  KIZielKoordinaten);
      
      case
        BelegungExtern
      is
         when SpeziesDatentypen.KI_Spieler_Enum =>
            KIDatentypen.Einheit_Aufgabe_Enum'Read (Stream (File => DateiLadenExtern),
                                                    KIBeschäftigt);
               
            KartenRecords.KartenfeldNaturalRecord'Read (Stream (File => DateiLadenExtern),
                                                        KIZielKoordinatenNachfolger);
               
            KIDatentypen.Einheit_Aufgabe_Enum'Read (Stream (File => DateiLadenExtern),
                                                    KIBeschäftigtNachfolger);
               
            AufgabenDatentypen.Einheiten_Aufgaben_Enum'Read (Stream (File => DateiLadenExtern),
                                                             KIVerbesserung);
            
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            EinheitenRecords.EinheitMeldungenArray'Read (Stream (File => DateiLadenExtern),
                                                         AlleMeldungen);
      end case;
      
      case
        LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => SpeziesExtern,
                                                   IDExtern      => ID)
      is
         when EinheitenDatentypen.Kein_Transport_Enum =>
            Ladung (Ladung'First) := 0;
            
         when others =>
            EinheitenDatentypen.Transportplätze'Read (Stream (File => DateiLadenExtern),
                                                       TransportplätzeBelegt);
            
            Ladung := (others => 0);
            
            TransportSchleife:
            for TransportSchleifenwert in EinheitenRecords.TransporterArray'First .. TransportplätzeBelegt loop
               
               EinheitenDatentypen.EinheitenbereichVorhanden'Read (Stream (File => DateiLadenExtern),
                                                                   Ladung (TransportSchleifenwert));
               
            end loop TransportSchleife;
      end case;
      
      case
        LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => SpeziesExtern,
                                                        IDExtern      => ID)
      is
         when EinheitenDatentypen.Kein_Transport_Enum =>
            WirdTransportiert := EinheitenKonstanten.LeerWirdTransportiert;
               
         when others =>
            EinheitenDatentypen.Einheitenbereich'Read (Stream (File => DateiLadenExtern),
                                                       WirdTransportiert);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                        IDExtern                   => ID);
            
            -- Wenn ich dafür ein entsprechendes System baue, dann muss ich die Koordinaten gar nicht bei der Karte speichern! äöü
            if
              WirdTransportiert = EinheitenKonstanten.LeerWirdTransportiert
            then
               Kartenplatzierung := True;
               
            else
               Kartenplatzierung := False;
               
               SchreibeEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                          TransporterExtern          => WirdTransportiert);
            end if;
            
            SchreibeEinheitenGebaut.KoordinatenLaden (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                      KoordinatenExtern          => Koordinaten,
                                                      KartenplatzierungExtern    => Kartenplatzierung);
            
            SchreibeEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                 HeimatstadtExtern          => Heimatstadt);
            
            SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                  LebenspunkteExtern         => Lebenspunkte,
                                                  RechnenSetzenExtern        => False);
            
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                     BewegungspunkteExtern      => Bewegungspunkte,
                                                     RechnenSetzenExtern        => False);
            
            SchreibeEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                      ErfahrungspunkteExtern     => Erfahrungspunkte,
                                                      AddierenSetzenExtern       => False);
            
            SchreibeEinheitenGebaut.Rang (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                          AddierenSetzenExtern       => False,
                                          RangExtern                 => Rang);
            
            SchreibeEinheitenGebaut.BeschäftigungLaden (EinheitSpeziesNummerExtern     => (SpeziesExtern, EinheitExtern),
                                                         BeschäftigungExtern           => Beschäftigung,
                                                         BeschäftigungNachfolgerExtern => BeschäftigungNachfolger);
            
            -- Das hier wird auch für die Festlegung der menschlichen Bewegung verwendet, muss also Belegungsunabhängig gespeichert werden.
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                       KoordinatenExtern          => KIZielKoordinaten);
            
            if
              BelegungExtern = SpeziesDatentypen.KI_Spieler_Enum
            then
               SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                       AufgabeExtern              => KIBeschäftigt);
               
               SchreibeEinheitenGebaut.KIZielKoordinatenNachfolger (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                                    KoordinatenExtern          => KIZielKoordinatenNachfolger);
               
               SchreibeEinheitenGebaut.KIBeschäftigtNachfolger (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                                 AufgabeExtern              => KIBeschäftigtNachfolger);
               
               SchreibeEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                       BeschäftigungExtern        => KIVerbesserung);
            
            else
               SchreibeEinheitenGebaut.AlleMeldungen (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                      MeldungExtern              => AlleMeldungen);
            end if;
            
            if
              Ladung (Ladung'First) = 0
            then
               null;
               
            else
               SchreibeEinheitenGebaut.GesamteLadung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitExtern),
                                                      LadungExtern               => Ladung);
            end if;
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenEinheitenLogik.Einheitenwerte: Konnte nicht geladen werden: LadenPrüfenExtern =" & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Einheitenwerte;

end LadenEinheitenLogik;
