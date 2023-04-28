with GrafikRecords;
with GrafikRecordKonstanten;
with GrafikKonstanten;

package EinstellungenGrafik is
   pragma Elaborate_Body;
   
   FensterEinstellungen : GrafikRecords.FensterRecord;
   
   Grafikeinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   procedure StandardeinstellungenLaden;
   
private
   
   FensterStandardEinstellungen : constant GrafikRecords.FensterRecord := (
                                                                           Fenstermodus => GrafikKonstanten.StandardFenster,
                                                                           
                                                                           Auflösung    => GrafikRecordKonstanten.Minimalauflösung,
                                                                           Farbtiefe    => 32,
                                                                           Bildrate     => 30
                                                                          );
   
   -- Der Mauszeiger wird aktuell in FensterGrafik festgelegt/verwendet. So lassen oder später hier mit einbauen um in Änderbar zu machen? äöü
   GrafikeinstellungenStandard : constant GrafikRecords.GrafikeinstellungenRecord := (
                                                                                      EbeneUnterhalbSichtbar => True
                                                                                     );
   
end EinstellungenGrafik;
