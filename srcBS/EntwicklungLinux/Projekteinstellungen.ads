with SystemRecords;

package Projekteinstellungen is
   pragma Preelaborate;

   Debug : constant SystemRecords.DebugRecord := (
                                                  VolleInformation => True,
                                                  FehlerWarnung    => True,
                                                  LinuxWindows     => True,
                                                  -- Das hier eventuell in die Endeinstellungen einbauen? äöü
                                                  NormalerText     => True
                                                 );

end Projekteinstellungen;
