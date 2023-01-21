package EinheitenDatentypen is
   pragma Pure;
      
   type MaximaleEinheitenMitNullWert is range 0 .. 1_000;
   subtype MaximaleEinheiten is MaximaleEinheitenMitNullWert range 1 .. MaximaleEinheitenMitNullWert'Last;
   
   

   type EinheitenIDMitNullWert is range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. EinheitenIDMitNullWert'Last;
   
   

   type Passierbarkeit_Enum is (
                                -- Weltraum
                                Weltraum_Enum,
                                
                                -- Himmel
                                Luft_Enum,
                                
                                -- Oberfläche
                                Wasser_Enum, Küstenwasser_Enum,
                                Boden_Enum,
                                
                                -- Unterfläche
                                Unterwasser_Enum, Unterküstenwasser_Enum,
                                Unterirdisch_Enum,
                                
                                -- Planetenkern
                                Planeteninneres_Enum, Lava_Enum
                               );

   subtype Passierbarkeit_Fliegen_Enum is Passierbarkeit_Enum range Weltraum_Enum .. Boden_Enum;
   
   subtype Passierbarkeit_Luftbereich_Enum is Passierbarkeit_Fliegen_Enum range Weltraum_Enum .. Luft_Enum;
   
   subtype Passierbarkeit_Oberfläche_Enum is Passierbarkeit_Fliegen_Enum range Wasser_Enum .. Boden_Enum;
   subtype Passierbarkeit_Oberwasser_Enum is Passierbarkeit_Oberfläche_Enum range Wasser_Enum .. Küstenwasser_Enum;
   
   subtype Passierbarkeit_Unterfläche_Enum is Passierbarkeit_Enum range Unterwasser_Enum .. Unterirdisch_Enum;
   subtype Passierbarkeit_Unterwasser_Enum is Passierbarkeit_Unterfläche_Enum range Unterwasser_Enum .. Unterküstenwasser_Enum;
   
   subtype Passierbarkeit_Planetenkern_Enum is Passierbarkeit_Enum range Planeteninneres_Enum .. Lava_Enum;
   
   

   type Einheitart_Enum is (
                            Leer_Einheitart_Enum,
                             
                            Arbeiter_Enum,
                            
                            Nahkämpfer_Enum, Fernkämpfer_Enum, Beides_Enum,
                            
                            -- Hier einmal Nutzung einbauen und dann für alle die Zusatzwirkungen mit der Effekteinstellung bestimmen? äöü
                            Einmalig_Enum,
                            
                            Cheat_Enum
                           );
   
   subtype Einheitart_Vorhanden_Enum is Einheitart_Enum range Einheitart_Enum'Succ (Einheitart_Enum'First) .. Einheitart_Enum'Last;
   subtype Einheitart_Standard_Enum is Einheitart_Vorhanden_Enum range Einheitart_Vorhanden_Enum'First .. Einmalig_Enum;
   subtype Einheitenart_Kampf_Enum is Einheitart_Vorhanden_Enum range Nahkämpfer_Enum .. Beides_Enum;
     
     

   type Einheit_Meldung_Art_Enum is (
                                     Aufgabe_Fertig_Enum, Einheit_In_Der_Nähe_Enum
                                    );
   
   type Einheit_Meldung_Enum is (
                                 Leer_Einheit_Meldung_Enum,
                                 
                                 Aufgabe_Abgeschlossen_Enum, Fremde_Einheit_Nahe_Enum
                                );
   
   subtype Einheit_Meldung_Verwendet_Enum is Einheit_Meldung_Enum range Einheit_Meldung_Enum'Succ (Einheit_Meldung_Enum'First) .. Einheit_Meldung_Enum'Last;
   
   

   type Bewegungspunkte is range -100 .. 100;
   subtype VorhandeneBewegungspunkte is Bewegungspunkte range 0 .. Bewegungspunkte'Last;
   
   
   
   type Lebenspunkte is range -1_000 .. 1_000;
   subtype VorhandeneLebenspunkte is Lebenspunkte range 1 .. Lebenspunkte'Last;
   
   
   
   type Erschöpfung is range 0 .. 10;
   
   
   
   type Bewegungsplan is range 0 .. VorhandeneBewegungspunkte'Last;
   subtype BewegungsplanVorhanden is Bewegungsplan range 1 .. Bewegungsplan'Last;
   
   
      
   type Transport_Enum is (
                           Kein_Transport_Enum,
                           
                           Klein_Transport_Enum, Mittel_Transport_Enum, Groß_Transport_Enum, Riesig_Transport_Enum, Gigantisch_Transport_Enum
                          );
   pragma Ordered (Transport_Enum);
   
   subtype Transport_Vorhanden_Enum is Transport_Enum range Transport_Enum'Succ (Transport_Enum'First) .. Transport_Enum'Last;
   
   
     
   -- Der Nullwert wird für die Auswahl von Städten/Einheiten benötigt, nicht entfernen.
   type Transportplätze is range 0 .. 8;
   subtype TransportplätzeVorhanden is Transportplätze range 1 .. Transportplätze'Last;

end EinheitenDatentypen;
