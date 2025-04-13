with TaskRecords;

package Logiktask is
   pragma Elaborate_Body;
   
   Warten : TaskRecords.WartenLogikRecord := (others => True);
   
   Eingabe : TaskRecords.EingabeLogikRecord;
   
   ScrollleisteVorhanden : Boolean := True;
      
end Logiktask;
