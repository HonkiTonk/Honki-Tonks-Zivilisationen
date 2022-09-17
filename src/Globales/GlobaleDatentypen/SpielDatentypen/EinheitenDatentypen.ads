pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package EinheitenDatentypen is
   
   -- Eigenen Datentyp für Arbeitszeit anlegen. äöü
   -- Eigene Datentypen für Erfahrung/Rang anlegen. äöü
   
   type MaximaleEinheitenMitNullWert is range 0 .. 1_000;
   subtype MaximaleEinheiten is MaximaleEinheitenMitNullWert range 1 .. MaximaleEinheitenMitNullWert'Last;

   type EinheitenIDMitNullWert is range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. EinheitenIDMitNullWert'Last;

   type Passierbarkeit_Enum is (
                                Boden_Enum,
                                
                                Wasser_Enum, Küstenwasser_Enum,
                                Unterwasser_Enum, Unterküstenwasser_Enum,
                                
                                Luft_Enum, Weltraum_Enum,
                                
                                Unterirdisch_Enum, Planeteninneres_Enum, Lava_Enum
                               );

   subtype Passierbarkeit_Vorhanden_Enum is Passierbarkeit_Enum range Boden_Enum .. Passierbarkeit_Enum'Last;
   subtype Passierbarkeit_Fliegen_Enum is Passierbarkeit_Vorhanden_Enum range Luft_Enum .. Weltraum_Enum;

   type Einheitart_Enum is (
                            Leer_Einheitart_Enum,
                             
                            Arbeiter_Enum,
                            
                            Nahkämpfer_Enum, Fernkämpfer_Enum, Beides_Enum,
                            
                            PZB_Enum,
                            
                            Cheat_Enum
                           );
   
   subtype Einheitart_Vorhanden_Enum is Einheitart_Enum range Arbeiter_Enum .. Einheitart_Enum'Last;
   subtype Einheitart_Standard_Enum is Einheitart_Vorhanden_Enum range Arbeiter_Enum .. PZB_Enum;
   subtype Einheitenart_Kampf_Enum is Einheitart_Vorhanden_Enum range Nahkämpfer_Enum .. Beides_Enum;

   type Einheit_Meldung_Art_Enum is (
                                     Aufgabe_Fertig_Enum, Einheit_In_Der_Nähe_Enum
                                    );
   type Einheit_Meldung_Enum is (
                                 Leer_Einheit_Meldung_Enum,
                                 
                                 Aufgabe_Abgeschlossen_Enum, Fremde_Einheit_Nahe_Enum
                                );
   subtype Einheit_Meldung_Verwendet_Enum is Einheit_Meldung_Enum range Aufgabe_Abgeschlossen_Enum .. Einheit_Meldung_Enum'Last;

   type BewegungFloat is digits 2 range -100.00 .. 100.00;
   subtype VorhandeneBewegungspunkte is BewegungFloat range 0.00 .. BewegungFloat'Last;
   
   type Lebenspunkte is range 0 .. 1_000;
   subtype LebenspunkteVorhanden is Lebenspunkte range 1 .. Lebenspunkte'Last;
      
   type Transport_Enum is (
                           Kein_Transport_Enum,
                           
                           Klein_Transport_Enum, Mittel_Transport_Enum, Groß_Transport_Enum, Riesig_Transport_Enum, Gigantisch_Transport_Enum
                          );
   pragma Ordered (Transport_Enum);
   
   subtype Transport_Vorhanden_Enum is Transport_Enum range Klein_Transport_Enum .. Gigantisch_Transport_Enum;
     
   -- Hier den Minimalwert bei 0 lassen, wenn ausversehen ein Transport zugewiesen wird, dann kann die Einheit trotzdem nicht transportieren.
   type Transportplätze is range 0 .. 10;
   subtype TransportplätzeVorhanden is Transportplätze range 1 .. Transportplätze'Last;

end EinheitenDatentypen;
